#!/usr/bin/env python


"""\
usage: %prog [action] [options]

This transfers the files in this directory to and from $HOME (or --home). The
action is either push (transfer to $HOME) or pull (transfer from $HOME). The
transfer itself is very simple-minded and does not attempt to merge conflicts
or anything. It just clobbers the destination files. The default action is
"push". """


import atexit
import datetime
import logging
import optparse
import os
import shutil
import sys
import time


__version__ = '$Revision:$'


LOG_FORMAT = (
    '%(asctime)s [%(levelname)s] %(name)s : %(message)s'
    )
LOG_LEVELS = {
    'very-quiet': logging.CRITICAL,
    'quiet': logging.WARNING,
    'normal': logging.INFO,
    'verbose': logging.DEBUG,
    }

if sys.platform == 'win32':
    timer = time.clock
else:
    timer = time.time


HOME = os.path.expanduser('~')
CWD = os.path.dirname(os.path.abspath(__file__))
DEFAULT_ACTION = 'push'
EXCLUDES = set(['.hg'])


def copy_files(targetdir, src, dest):
    """\
    This walks target directory and, for all files that exist in src, it copies
    them to dest, maintaining the directory structure.

    """

    if not os.path.exists(dest):
        logging.info('creating %s', dest)
        os.makedirs(dest)
    for child in os.listdir(targetdir):
        if child in EXCLUDES:
            continue
        fullsrc = os.path.join(src, child)
        if os.path.isdir(fullsrc):
            copy_files(os.path.join(targetdir, child), fullsrc, os.path.join(dest, child))
        elif os.path.isfile(fullsrc):
            logging.info('cp %s %s', fullsrc, dest)
            shutil.copy(fullsrc, dest)
        else:
            logging.info('target not found or not a file or directory in src: %s', fullsrc)


def publish(action, repo, home):
    """\
    This transfers files between repo and home.

    The direction of the transfer is determined by action.

    """

    if action == 'push':
        src = repo
        dest = home
    elif action == 'pull':
        src = home
        dest = repo
    else:
        logging.error('Invalid action: %s', action)
        raise Exception, ('Invalid action: %s' % action)
    copy_files(repo, src, dest)


def parse_args(argv):
    """\
    This parses the command-line arguments in argv and returns a tuple
    containing the options and other arguments.

    """

    op = optparse.OptionParser(usage=__doc__, version='%prog '+__version__)
    op.add_option('-H', '--home', action='store', dest='home', default=HOME,
                  help='The working home directory to transfer files to and from. '
                       'Default is %default.')
    op.add_option('-r', '--repository', action='store', dest='repo', default=CWD,
                  help='The local repository directory. Default is %default.')
    op.add_option('--log-dest', action='store', dest='log_file', default='STDOUT',
                  help='The name of the file to send log messages to. "STDOUT" will print to '
                       'the screen. Default=%default.')
    op.add_option('--log-level', action='store', dest='log_level', choices=LOG_LEVELS.keys(),
                  default='normal',
                  help='The level of logging information to output. Valid choices are '
                       '"quiet", "normal", and "verbose". Default="%default".')
    (opts, args) = op.parse_args(argv)
    return (opts, args)


def setup_logging(opts):
    """\
    This sets up the logging system, based on the values in opts. Specifically,
    this looks for the log_file and log_level attributes on opts.

    """

    args = {}
    if opts.log_file == 'STDOUT':
        args['stream'] = sys.stdout
    else:
        args['filename'] = opts.log_file
    logging.basicConfig(
        level=LOG_LEVELS[opts.log_level],
        format=LOG_FORMAT,
        **args
        )
    atexit.register(logging.shutdown)


def main(argv=None):
    (opts, args) = parse_args(argv or sys.argv[1:])
    if not args:
        args = [DEFAULT_ACTION]
    setup_logging(opts)
    try:
        start = timer()
        publish(args[0], opts.repo, opts.home)
        end = timer()
        logging.info('done')
        logging.info('elapsed time: %s', datetime.timedelta(seconds=end-start))
    except SystemExit:
        return 0
    except KeyboardInterrupt:
        logging.warning('KeyboardInterrupt')
        return 2
    except:
        logging.exception('ERROR')
        return 1
    else:
        return 0


if __name__ == '__main__':
    sys.exit(main())


