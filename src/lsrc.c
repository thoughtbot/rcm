#include <sys/queue.h>

#include <err.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

#include "compat.h"

struct args {
	int			 show_sigils, verbosity, version;
	char			*hostname;
	TAILQ_ENTRY(args)	 includes;
	/*
	struct {
		struct args *tqe_next;
		struct args *qual *tqe_prev;
	} includes;
	*/
};

__dead void	usage(int);
void		init_args(struct args *);

int
main(int argc, char *argv[])
{
	int	 	ch;
	struct args	a;
	/* I have no idea what I'm doing: */
	TAILQ_HEAD(tailhead, args) head;
	/*
	struct tailhead {								\
	   struct args *tqh_first;
	   struct args *tqh_last;
	}
	*/
	struct tailhead	*headp;
	TAILQ_INIT(&head);
	/*
	(&head)->tqh_first = NULL;
	(&head)->tqh_last = &(&head)->tqh_first;
	*/
	a.includes = malloc(sizeof(struct args));

	init_args(&a);

	while ((ch = getopt(argc, argv, ":FVqvhI:x:B:S:s:t:d:")) != -1)
		switch (ch) {
		case 'F':
			a.show_sigils = 1;
			break;
		case 'h':
			usage(0);
			/* NOTREACHED */
			break;
		case 'I':
			TAILQ_INSERT_TAIL(&head, a, includes);
			/*
			(args)->includes.tqe_next = NULL;
			(args)->includes.tqe_prev = (&head)->tqh_last;
			*(&head)->tqh_last = (args);
			(&head)->tqh_last = &(args)->includes.tqe_next;
			*/
			/* includes="$includes $OPTARG" */
			break;
		case 't':
			/* TODO: */
			arg_tags="$arg_tags $OPTARG";
			break;
		case 'v':
			a.verbosity++;
			break;
		case 'q':
			a.verbosity--;
			break;
		case 'd':
			/* TODO: */
			dotfiles_dirs="$dotfiles_dirs $OPTARG";
			break;
		case 'V':
			a.version = 1;
			break;
		case 'x':
			/* TODO: */
			excludes="$excludes $OPTARG";
			break;
		case 'S':
			/* TODO: */
			symlink_dirs="$symlink_dirs $OPTARG";
			break;
		case 's':
			/* TODO: */
			never_symlink_dirs="$never_symlink_dirs $OPTARG";
			break;
		case 'B':
			if ((a.hostname = calloc(strlen(optarg) + 1, sizeof(char))) == NULL)
				err(1, "calloc");
			a.hostname = optarg;
			break;
		case '?':
			usage(64);
			/* NOTREACHED */
			break;
		}

	free(a.hostname);

	return 0;
}

void
usage(int e)
{
  printf("Usage: lsrc [-FhqVv] [-B HOSTNAME] [-d DOT_DIR] [-I EXCL_PAT] [-S EXCL_PAT ] [-t TAG] [-x EXCL_PAT]\n");
  printf("see lsrc(1) and rcm(7) for more details\n");

  exit(e);
}

void
init_args(struct args *a)
{
	a->show_sigils = a->verbosity = a->version = 0;
}
