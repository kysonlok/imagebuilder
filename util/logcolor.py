#!/usr/bin/env python

import sys

def loginfo(*args):
    print u"\u001b[33m%s\u001b[0m" % args

def logwarning(*args):
    print u"\u001b[35m%s\u001b[0m" % args

def logerror(*args):
    print u"\u001b[31m%s\u001b[0m" % args
    sys.exit(1)
