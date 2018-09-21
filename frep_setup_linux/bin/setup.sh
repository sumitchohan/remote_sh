#!/bin/sh
FLAG=0
FILE=strserv
#DSTDIR=/data/data/com.x0.strai.frep/app_bin
DSTDIR=${0%/*}

# Note: Since Android 2.3.3 do not support if [ ], use case instead.

# Adjust dir
getdir() {
  case $DSTDIR in
  *app_bin)
  ;;
  *)
  DSTDIR=/data/data/com.x0.strai.frep/app_bin
  ;;
  esac
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
#  return $9
}

# Check pid and kill if already running.
killserv() {
  PS=`ps $FILE`
  PID=`gettenth $PS`
  case $PID in
    "");;
    0);;
    *)
    kill $PID
    echo PID $PID $FILE killed.
    ;;
  esac
# patch for Android 6
  PS=`ps /data/local/tmp/strserv`
  PID=`gettenth $PS`
  case $PID in
    "");;
    0);;
    *)
    kill $PID
    echo PID $PID strserv killed.
    ;;
  esac
  PS=`ps /data/data/com.x0.strai.frep/app_bin/strserv`
  PID=`gettenth $PS`
  case $PID in
    "");;
    0);;
    *)
    kill $PID
    echo PID $PID strserv killed.
    ;;
  esac
}

# Start binary if it exists.
startserv() {
  for i in ${DSTDIR}/*
  do case $i in
    *strserv)
    echo Start $i
    $i &
    FLAG=1
  esac
  done
}

getdir
killserv
killserv
startserv

# Note if binary not found / has removed.
case $FLAG in
  0)
  echo ${DSTDIR}/${FILE} not found.  Launch FRep on your Android device and retry.
  ;;
esac

exit
