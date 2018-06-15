from uiautomator import device as d
import sys
import signal
import random
 

def execute():
    print "Connecting to device..."
    d.info
    print "Connected"
    print "Clicking 100 100"
    UiDevice device = UiDevice.getInstance(InstrumentationRegistry.getInstrumentation())
    device.findObject(uiSelector).pinchOut(20, 20);
    
def exit_gracefully(signum, frame):
    print "Gracefully exiting"
    signal.signal(signal.SIGINT, signal.getsignal(signal.SIGINT)) 
    sys.exit(1)
if __name__ == '__main__':
    signal.signal(signal.SIGINT, exit_gracefully)
    execute()
