#!/usr/bin/env python

import glob
import os
import os.path
import shutil
import sys

def main(argv=None):
    if argv is None:
        argv = sys.argv

    home = os.environ['HOME']
    linkables = glob.glob('*/**.symlink')

    skip_all = False
    overwrite_all = False
    backup_all = False

    for linkable in linkables:
        overwrite = False
        backup = False

        filename = os.path.split(linkable)[1].partition('.')[0]
        link_name = os.path.join(home, '.{0}'.format(filename))
        abs_linkable = os.path.join(os.getcwd(), linkable)

        if os.path.isfile(link_name) or os.path.islink(link_name) or os.path.isdir(link_name):
            if not (skip_all or overwrite_all or backup_all):
                action = raw_input('File/Directory already exists: {0}, what do you want to do? [s]kip, [S]kip all, [o]verwrite, [O]verwrite all, [b]ackup, [B]ackup all: '.format(link_name))
                if('s' == action):
                    continue
                elif('S' == action):
                    skip_all = True
                elif('o' == action):
                    overwrite = True
                elif('O' == action):
                    overwrite_all = True
                elif('b' == action):
                    backup = True
                elif('B' == action):
                    backup_all = True

            if overwrite or overwrite_all:
                os.unlink(link_name)
            if backup or backup_all:
                shutil.move(link_name, '{0}.backup'.format(link_name))

        if not skip_all:
            os.symlink(abs_linkable, link_name)

    return 0


if __name__=='__main__':
    sys.exit(main())

# vim:et:ts=4:sw=4:sts=4:fdm=indent:fdn=2:fdl=2
