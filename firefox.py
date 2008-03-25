

import glob
import os
import sys


def get_profile_dir():
    if os.name == 'nt':
        basedir = os.path.join(
            os.environ['appdata'],
            'Mozilla',
            'Firefox',
            'Profiles',
            )
    elif os.name == 'posix':
        basedir = os.path.join(
            os.environ['home'],
            '.mozilla',
            'firefox',
            )
    else:
        basedir = os.getcwd()
    dirs = [
        dirname
        for dirname in glob.glob(os.path.join(basedir, '*.default'))
        if os.path.isdir(dirname)
        ]
    for dirname in dirs:
        if os.path.exists(os.path.join(dirname, 'bookmarks.html')):
            return dirname
    return None


