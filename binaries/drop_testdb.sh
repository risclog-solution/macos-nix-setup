#!/usr/bin/env python3.8

import subprocess
import re
import argparse

parser = argparse.ArgumentParser(description='Remove all PostgreSQL whose name'
                                             ' begins with the given prefix')
parser.add_argument('prefix', help='Prefix used to match DBs')
parser.add_argument(
    '-n', '--dry', action="store_true",
    help='Only show which DBs would be removed, but do not perform removal')

options = parser.parse_args()
db_list = subprocess.check_output("psql -l", shell=True)
for entry in db_list.splitlines():
    if not entry:
        continue
    db_name = re.sub(b'\s+', b' ', entry).strip().split()[0]
    db_name = db_name.decode()
    if not db_name.startswith(options.prefix):
        continue
    print('dropdb {}'.format(db_name))
    if not options.dry:
        subprocess.check_output(['dropdb', db_name])
