#!/bin/sh
curpath=`pwd`
scriptpath=${0%/*}
arguments=$*
tmpfile=tmp
cnffile=confirmed
ADBPATH=bin/adb

if [ $0 = $scriptpath ] ; then
  scriptpath=.
fi

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
  $ADBPATH devices -l >$tmpfile
  # while~do~done with redirecting file because of variable lost.
  while read line ; do
    if [ -n "$line" ] ; then
      device="`echo $line | awk '{print $1}'`"
      if [ $devnum -gt 0 ] ; then
        echo "[$devnum] $line"
      fi
      devnum=`expr $devnum + 1`
    fi
  done <$tmpfile

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
    done <$tmpfile
  fi
  rm $tmpfile

  if [ -n $seldevice ] ; then
    arguments="-s $seldevice"
    echo "[$selnum] $seldevice is selected."
  else
    echo "Retry with only single Android device connection, or designate"
    echo "single Android device by option -s (single serial from above)"
    echo "ex.) linux.sh -s 00000000"
    exit 1
  fi
}

funcusbmode() {
  if [ -f $cnffile ] ; then
    return 0
  fi
  
  echo "  Set USB connection mode as Charging (or File Transfer on specific devices)."
  echo ""
  echo "Push Enter after confirmation. (1 to skip confirmation from next time)"
  read selnum
  selnum=`funcnumeric $selnum`

  if [ $selnum -eq 1 ] ; then
    echo "Confirmation will be skipped from next time."
    touch $cnffile
  fi
}

cd $scriptpath
chmod +x $ADBPATH

$ADBPATH devices > /dev/null 2>&1

# check Android version and USB debug connection
passed=0
while [ $passed -eq 0 ] ; do
  versionsdk=`$ADBPATH $arguments shell getprop ro.build.version.sdk 2>&1`
  case $? in
    # passed (no error)
    0)
    passed=1
    ;;
    # error
    *)
    case $versionsdk in
      # skip sdk check when getprop denied or not found.
      *enied)
      passed=1
      ;;
      *getprop*found)
      passed=1
      ;;
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
      echo $versionsdk
      funcerr
      ;;
    esac
    ;;
  esac
done

# remove CR code
versionsdk=`echo $versionsdk | tr -c -d "0123456789"`
versionsdk=`funcnumeric $versionsdk`
# echo Android version_sdk: $versionsdk

# branch by Android version
if [ $versionsdk -ge 26 ] ; then
  echo "Switching to linux_alt.sh for Android 8.0 or later."
  echo "- Keep USB debugging: ON."
  echo "- Availablity after USB disconnection depends on current connection mode."
  funcusbmode
  cd $curpath
  $scriptpath/linux_alt.sh $arguments
elif [ $versionsdk -ge 19 ] ; then
  echo "Switching to linux_alt.sh for Android 4.4 or later."
  echo ""
  cd $curpath
  $scriptpath/linux_alt.sh $arguments
else
  echo "If permission denied error is shown, try another linux_alt.sh script."
  pushed=`$ADBPATH $arguments push bin/setup.sh /data/data/com.x0.strai.frep/app_bin/setup.sh 2>&1`
  case $? in
    0)
    # start setup script
    echo "After Server Started, push Ctrl-C to exit setup script."
    echo ""
    echo "sh /data/data/com.x0.strai.frep/app_bin/setup.sh &" | $ADBPATH $arguments shell
    ;;
    *)
    # push failed. if permission denied, retry on tmp.
    case $pushed in
      *denied)
      $ADBPATH $arguments push bin/setup.sh /data/local/tmp/setup.sh
      case $? in
        0)
        echo "sh /data/local/tmp/setup.sh &" | $ADBPATH $arguments shell
        ;;
        *)
        echo $pushed
        funcerr
        ;;
      esac
      ;;
      *)
      echo $pushed
      funcerr
      ;;
    esac
    ;;
  esac
fi

cd $curpath
exit 0

