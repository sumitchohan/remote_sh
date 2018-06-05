#! /usr/bin/env monkeyrunner

from com.android.monkeyrunner import MonkeyRunner, MonkeyDevice
import sys
import signal
import random
import datetime

device = None

def execute():
    print "Connecting to device..."
    device = MonkeyRunner.waitForConnection()
    print "Connected"
    result = device.takeSnapshot()
    print "Clicked.."
    now = datetime.datetime.now()
    file = "~\\Desktop\\ScreenShots\\cap1"+now.strftime("%d%m%Y-%H%M%S")+".png"
    result.writeToFile(file,'png')	
    result = device.takeSnapshot()
    print "Clicked.."
    now = datetime.datetime.now()
    file = "~\\Desktop\\ScreenShots\\cap2"+now.strftime("%d%m%Y-%H%M%S")+".png"
    result.writeToFile(file,'png')	
    result = device.takeSnapshot()
    print "Clicked.." 
def exit_gracefully(signum, frame):
    print "Gracefully exiting"
    signal.signal(signal.SIGINT, signal.getsignal(signal.SIGINT))
    if device is not None:
        device.shell('killall com.android.commands.monkey')
    sys.exit(1)
if __name__ == '__main__':
    signal.signal(signal.SIGINT, exit_gracefully)
    execute()
