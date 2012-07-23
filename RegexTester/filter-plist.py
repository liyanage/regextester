#!/usr/bin/env python

import os
del(os.environ['MACOSX_DEPLOYMENT_TARGET'])

import plistlib, re

info_plist_full_path = os.path.join(os.environ['BUILT_PRODUCTS_DIR'], os.environ['INFOPLIST_PATH'])

plist = plistlib.readPlist(info_plist_full_path)

for key in [key for key in plist if re.match('^(DT|Build)', key)]:
	del(plist[key])

plistlib.writePlist(plist, info_plist_full_path)
print info_plist_full_path