

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
        os.path.join(basedir, fn)
        for fn in os.listdir(basedir)
        if os.path.isdir(os.path.join(basedir, fn))
        ]
    for dirname in dirs:
        if os.path.exists(os.path.join(dirname, 'bookmarks.html')):
            return dirname
    return None


