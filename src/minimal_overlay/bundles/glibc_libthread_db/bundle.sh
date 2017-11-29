#!/bin/sh

set -e

. ../../common.sh

if [ ! -d $SYSROOT ] ; then
  echo "Cannot continue - GLIBC is missing. Please buld GLIBC first."
  exit 1
fi

mkdir -p "$WORK_DIR/overlay/$BUNDLE_NAME"
cd $WORK_DIR/overlay/$BUNDLE_NAME

rm -rf $DEST_DIR

mkdir -p $DEST_DIR/lib
cp $SYSROOT/lib/libthread_db.so.1 $DEST_DIR/lib/
ln -s libthread_db.so.1 $DEST_DIR/lib/libthread_db.so

echo "Reducing $BUNDLE_NAME size"
strip -g $DEST_DIR/lib/*

cp -r $DEST_DIR/* $OVERLAY_ROOTFS

echo "$BUNDLE_NAME has been installed."

cd $SRC_DIR
