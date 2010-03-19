
import ipy_user_conf

import os


def main():
    ip = ipy_user_conf.ip
    sri_file = os.path.expanduser('~/sri/conf/pythonrc')
    if os.path.exists(sri_file):
        ip.ex('execfile("%s")' % (sri_file,))


main()

