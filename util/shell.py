#!/usr/bin/env python

import os

from subprocess import PIPE
from subprocess import Popen
from subprocess import STDOUT
from subprocess import CalledProcessError

from logcolor import loginfo
from logcolor import logerror
from logcolor import logwarning

def run_shell(name, description, command, cwd = os.getcwd()):
    loginfo("Running command: %s" % command)
    try:
        directory = cwd+"/buildlogs"
        if not os.path.isdir(directory):
            os.mkdir(directory)

        fp = open("%s/%s.log" % (directory, name), "a+")
    except:
        logerror("Failed to create logfile")

    try:
        proc = Popen(
            command,
            stdout=PIPE,
            stderr=STDOUT,
            cwd=cwd
        )

        while proc.poll() is None:
            for line in iter(proc.stdout.readline,''):
                fp.write(line)

    except (OSError, CalledProcessError) as exception:
        fp.close()
        logerror("%s: %s failed" % (name, description))

    else:
        fp.close()

        if proc.returncode == 0:
            loginfo("%s: %s success" % (name, description))
        else:
            logerror("%s: %s failed" %(name, description))

