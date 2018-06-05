#! /usr/bin/env monkeyrunner

from com.android.monkeyrunner import MonkeyRunner, MonkeyDevice
import sys
import signal
import random

device = None

def execute():
    print "Connecting to device..."
    device = MonkeyRunner.waitForConnection()
    print "Connected"
    tap_positions = [[200, 400], [300, 410]]
    tap_sleep_time = 0.005
    old_phone_rest_time = 5
    old_phone_sleep_interval = 1000
    old_phone_sleep_counter = 0
    print "Tapping..."
    while True:
        for tap_position in tap_positions:
            device.touch(tap_position[0] + random.randint(1, 100),
                         tap_position[1] + random.randint(1, 100),
                         'UP')
        MonkeyRunner.sleep(tap_sleep_time)
        old_phone_sleep_counter += 1
        if old_phone_sleep_counter == old_phone_sleep_interval:
            print "Letting my old phone have a %s second rest" % old_phone_rest_time
            MonkeyRunner.sleep(old_phone_rest_time)
            old_phone_sleep_counter = 0
def exit_gracefully(signum, frame):
    print "Gracefully exiting"
    signal.signal(signal.SIGINT, signal.getsignal(signal.SIGINT))
    if device is not None:
        device.shell('killall com.android.commands.monkey')
    sys.exit(1)
if __name__ == '__main__':
    signal.signal(signal.SIGINT, exit_gracefully)
    execute()