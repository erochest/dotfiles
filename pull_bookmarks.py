

import os
import shutil

import firefox


def main():
    prof_dir = firefox.get_profile_dir()
    bookmarks = os.path.join(prof_dir, 'bookmarks.html')
    print 'cp "%s" ./bookmarks.html' % bookmarks
    shutil.copy(bookmarks, './bookmarks.html')


if __name__ == '__main__':
    main()

