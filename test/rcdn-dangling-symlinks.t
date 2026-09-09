  $ . "$TESTDIR/helper.sh"

Without -D, rcdn should not remove managed dangling symlinks

  $ touch .dotfiles/alpha
  > rcup >/dev/null
  > rm .dotfiles/alpha
  > rcdn >/dev/null
  $ assert "alpha should still be a dangling symlink" -h "$HOME/.alpha"

With -D, rcdn should remove managed dangling symlinks

  $ rcdn -D >/dev/null
  $ refute "alpha should be removed when -D is passed" -h "$HOME/.alpha"

With -D, rcdn should keep unmanaged dangling symlinks

  $ ln -s "$HOME/not-managed-target" "$HOME/.outside"
  $ rcdn -D >/dev/null
  $ assert "outside should still be a dangling symlink" -h "$HOME/.outside"

With -D and FILE arguments, cleanup should be restricted to those files

  $ touch .dotfiles/one .dotfiles/two
  > rcup >/dev/null
  > rm .dotfiles/one .dotfiles/two
  $ assert "one should be dangling symlink" -h "$HOME/.one"
  $ assert "two should be dangling symlink" -h "$HOME/.two"
  $ rcdn -D one >/dev/null
  $ refute "one should be removed" -h "$HOME/.one"
  $ assert "two should remain because it was not requested" -h "$HOME/.two"

With -D, rcdn should not remove dangling symlinks inside source dotfiles dirs

  $ ln -s "$HOME/.dotfiles/missing-in-source" "$HOME/.dotfiles/internal-dangling"
  $ rcdn -D >/dev/null
  $ assert "internal source-dir dangling link should not be removed" -h "$HOME/.dotfiles/internal-dangling"

With -D and multiple FILE arguments, every selected link should be removed

  $ ln -s "$HOME/.dotfiles/first-missing" "$HOME/.first-missing"
  > ln -s "$HOME/.dotfiles/second-missing" "$HOME/.second-missing"
  > rcdn -D first-missing second-missing >/dev/null
  $ refute "first requested link should be removed" -h "$HOME/.first-missing"
  $ refute "second requested link should be removed" -h "$HOME/.second-missing"

With multiple dotfiles roots, cleanup should recognize each root

  $ mkdir "$HOME/other-dotfiles"
  > ln -s "$HOME/.dotfiles/first-root-missing" "$HOME/.first-root-missing"
  > ln -s "$HOME/other-dotfiles/second-root-missing" "$HOME/.second-root-missing"
  > rcdn -D -d "$HOME/.dotfiles" -d "$HOME/other-dotfiles" >/dev/null
  $ refute "link from first root should be removed" -h "$HOME/.first-root-missing"
  $ refute "link from second root should be removed" -h "$HOME/.second-root-missing"

Source directories should remain protected when multiple roots are selected

  $ assert "internal link should remain with multiple selected roots" -h "$HOME/.dotfiles/internal-dangling"

Dangling link names should be read literally

  $ ln -s "$HOME/.dotfiles/missing space" "$HOME/.missing space"
  > ln -s "$HOME/.dotfiles/missing-backslash" "$HOME/.missing\\backslash"
  > rcdn -D >/dev/null
  $ refute "name with spaces should be removed" -h "$HOME/.missing space"
  $ refute "name with a backslash should be removed" -h "$HOME/.missing\\backslash"

Selected file arguments should preserve spaces

  $ ln -s "$HOME/.dotfiles/selected space" "$HOME/.selected space"
  > ln -s "$HOME/.dotfiles/other space" "$HOME/.other space"
  > rcdn -D "selected space" >/dev/null
  $ refute "selected spaced name should be removed" -h "$HOME/.selected space"
  $ assert "unselected spaced name should remain" -h "$HOME/.other space"

Cleanup respects exclusions, including excluded parent directories

  $ mkdir -p .dotfiles/config .config
  > ln -s "$HOME/.dotfiles/excluded" .excluded
  > ln -s "$HOME/.dotfiles/config/missing" .config/missing
  > ln -s "$HOME/.dotfiles/included" .included
  > rcdn -D -x 'excluded config' >/dev/null
  $ assert "excluded link should remain" -h .excluded
  $ assert "child of excluded directory should remain" -h .config/missing
  $ refute "non-excluded link should be removed" -h .included
  $ mkdir config
  > touch config/live
  > rcdn -D -x 'config/*' >/dev/null
  $ assert "path glob should preserve a missing child" -h .config/missing
  $ ln -s "$HOME/.dotfiles/included" .included
  > ln -s "$HOME/.dotfiles/allowed" .allowed
  > rcdn -D -x 'excluded config included' -I included >/dev/null
  $ refute "include override should allow cleanup" -h .included
  $ refute "include argument should not restrict positional file selection" -h .allowed
  $ assert "include override should not select other excluded links" -h .config/missing

  $ ln -s "$HOME/.dotfiles/excluded" .excluded

Root-qualified exclusions and configuration defaults apply to missing sources

  $ ln -s "$HOME/other-dotfiles/excluded" .other-excluded
  > echo 'EXCLUDES="other-dotfiles:excluded"' > "$RCRC"
  > rcdn -D -d .dotfiles -d other-dotfiles >/dev/null
  $ assert "root-qualified excluded link should remain" -h .other-excluded
  $ refute "same name in another root should be removed" -h .excluded
  $ rcdn -D -d other-dotfiles -x unrelated >/dev/null
  $ refute "CLI exclusions should override configured exclusions" -h .other-excluded
  $ rm "$RCRC"

Cleanup removes only selected tag and host sources, leaving hook sources alone

  $ mkdir -p .dotfiles/tag-work .dotfiles/tag-personal .dotfiles/host-selected .dotfiles/host-other .dotfiles/hooks
  > ln -s "$HOME/.dotfiles/tag-work/work" .work
  > ln -s "$HOME/.dotfiles/tag-personal/personal" .personal
  > ln -s "$HOME/.dotfiles/host-selected/host" .host
  > ln -s "$HOME/.dotfiles/host-other/other-host" .other-host
  > ln -s "$HOME/.dotfiles/hooks/missing" .hook
  > rcdn -D -t work -B selected >/dev/null
  $ refute "selected tag should be removed" -h .work
  $ refute "selected host should be removed" -h .host
  $ assert "unselected tag should remain" -h .personal
  $ assert "unselected host should remain" -h .other-host
  $ assert "hooks are not managed files" -h .hook
  $ echo 'TAGS=personal; HOSTNAME=other' > "$RCRC"
  > rcdn -D >/dev/null
  $ refute "configured tag should be removed" -h .personal
  $ refute "configured host should be removed" -h .other-host

Explicit nested FILE arguments use the same exclusion path spelling as lsrc

  $ mkdir -p .config
  > ln -s "$HOME/.dotfiles/config/missing" .config/missing
  > rcdn -D -x './config/*' config/missing >/dev/null
  $ assert "explicit nested excluded link should remain" -h .config/missing
  $ rcdn -D -x unrelated config/missing >/dev/null
  $ refute "explicit nested non-excluded link should be removed" -h .config/missing

Ambiguous source paths are preserved without hanging or escaping the root

  $ ln -s "$HOME/.dotfiles//missing" .double-slash
  > ln -s "$HOME/.dotfiles/tag-personal//missing" .tag-double-slash
  > ln -s "$HOME/.dotfiles/./tag-work/missing" .dot-path
  > ln -s "$HOME/.dotfiles/../missing" .parent-path
  > rcdn -D >/dev/null
  $ assert "repeated separator at source root should be preserved" -h .double-slash
  $ assert "repeated separator inside selected tag should be preserved" -h .tag-double-slash
  $ assert "dot segment should not bypass tag selection" -h .dot-path
  $ assert "parent traversal should be preserved" -h .parent-path
