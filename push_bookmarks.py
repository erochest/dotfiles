

import os
import shutil

import firefox


def main():
    prof_dir = firefox.get_profile_dir()
    bookmarks = os.path.join(prof_dir, 'bookmarks.html')
    print 'cp ./bookmarks.html "%s"' % bookmarks
    shutil.copy('./bookmarks.html', bookmarks)


if __name__ == '__main__':
    main()

