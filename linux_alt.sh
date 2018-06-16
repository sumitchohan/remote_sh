#!/bin/sh
curpath=`pwd`
scriptpath=${0%/*}
arguments=$*
tmpfilepath=$scriptpath/tmp
ADBPATH=bin/adb

funcerr() {
  echo "Setup failed. Please check followings."
  echo "- Once Start FRep on your Android device."
  echo "- Connect your Device with Development | USB Debugging."
  echo "See also support page. http://strai.x0.com/frep/"
  cd $curpath
  exit 1
}

funcoffline() {
  echo "Before continuing, Allow USB debugging on Android device. (Ctrl-C to cancel)"
  read tmpinput
}

funcnumeric() {
  numcand=$1
  expr "$numcand" + 1 >/dev/null 2>&1
  # -lt 2 Numeric
  if [ $? -ge 2 ] ; then
    numcand=0
  fi
  echo $numcand
# return $numcand
}

funcdevice() {
  echo "Multiple Android devices found."
  devnum=0
  $ADBPATH devices -l >$tmpfilepath
  # while~do~done with redirecting file because of variable lost.
  while read line ; do
    if [ -n "$line" ] ; then
      device="`echo $line | awk '{print $1}'`"
      if [ $devnum -gt 0 ] ; then
        echo "[$devnum] $line"
      fi
      devnum=`expr $devnum + 1`
    fi
  done <$tmpfilepath

  echo "Enter the number of device to setup FRep. (0 to cancel)"
  read selnum
  seldevice=
  devnum=0
  selnum=`funcnumeric $selnum`

  if [ $selnum -eq 0 ] ; then
    echo "Setup cancelled."
    exit 0
  else
    # while~do~done with redirecting file because of variable lost.
    while read line ; do
    if [ -n "$line" ] ; then
      if [ $devnum -eq $selnum ] ; then
        seldevice="`echo $line | awk '{print $1}'`"
        break
      fi
      devnum=`expr $devnum + 1`
    fi
    done <$tmpfilepath
  fi
  rm $tmpfilepath

  if [ -n $seldevice ] ; then
    arguments="-s $seldevice"
    echo "[$selnum] $seldevice is selected."
  else
    echo "Retry with only single Android device connection, or designate"
    echo "single Android device by option -s (single serial from above)"
    echo "ex.) linux_alt.sh -s 00000000"
    exit 1
  fi
}

# Return only first pid in ps result.
gettenth() {
  case $# in
    [0-9])
    return 0
    ;;
  esac
# shift to retrieve 10th arg
  shift
  echo $9
}

# get pid in pid file.
getfirst() {
  case $# in
    0)
    return 0
    ;;
  esac
  echo $1
}

# Check pid and kill if already running.
killserv() {
# for Android 7
  PS=`$ADBPATH $arguments shell cat /data/data/com.x0.strai.frep/app_bin/strserv.pid`
  PID=`getfirst $PS`
  case $PID in
    "");;
    0);;
    *)
    $ADBPATH $arguments shell kill $PID
    echo PID $PID strserv killed.
    ;;
  esac
# for Android ~5.x
  PS=`$ADBPATH $arguments shell ps strserv`
  PID=`gettenth $PS`
  case $PID in
    "");;
    0);;
    *)
    $ADBPATH $arguments shell kill $PID
    echo PID $PID strserv killed.
    ;;
  esac
# patch for Android 6
  PS=`$ADBPATH $arguments shell ps /data/local/tmp/strserv`
  PID=`gettenth $PS`
  case $PID in
    "");;
    0);;
    *)
    $ADBPATH $arguments shell kill $PID
    echo PID $PID strserv killed.
    ;;
  esac
  PS=`$ADBPATH $arguments shell ps /data/data/com.x0.strai.frep/app_bin/strserv`
  PID=`gettenth $PS`
  case $PID in
    "");;
    0);;
    *)
    $ADBPATH $arguments shell kill $PID
    echo PID $PID strserv killed.
    ;;
  esac
}

cd $scriptpath
chmod +x $ADBPATH
$ADBPATH devices > /dev/null 2>&1

# place binary and check USB debug connection
passed=0
while [ $passed -eq 0 ] ; do
  copied=`$ADBPATH $arguments shell "cat /data/data/com.x0.strai.frep/app_bin/strserv > /data/local/tmp/strserv" 2>&1`
  case $? in
    # passed (no error), start server
    0)
    passed=1
    $ADBPATH $arguments shell "chmod 777 /data/local/tmp/strserv"
    killserv
    echo "After Server Started, push Ctrl-C to exit setup script."
    echo "/data/local/tmp/strserv -c &" | $ADBPATH $arguments shell -x
    ;;
    *)
    # error
    case $copied in
      # error: more than one device/emulator (continue)
      *emulator)
      funcdevice
      ;;
      # error: device offline (continue)
      *offline)
      funcoffline
      ;;
      # error: device unauthorized (continue)
      *unauthorized*)
      funcoffline
      ;;
      # other error
      *)
      echo $copied
      funcerr
      ;;
    esac
    ;;
  esac
done

cd $curpath
exit 0

