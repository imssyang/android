#!/bin/bash

APP=android
HOME=/opt/$APP

_mkdir() {
  name=$1
  if [[ ! -d $name ]]; then
    mkdir -p $name
  fi
}

_rmdir() {
  name=$1
  if [[ -d $name ]]; then
    rm -rf $name
  fi
}

_create_symlink() {
  src=$1
  dst=$2
  if [[ ! -d $dst ]] && [[ ! -s $dst ]]; then
    ln -s $src $dst
    echo "($APP) create symlink: $src -> $dst"
  fi
}

_delete_symlink() {
  dst=$1
  if [[ -d $dst ]] || [[ -s $dst ]]; then
    rm -rf $dst
    echo "($APP) delete symlink: $dst"
  fi
}

_bin_files=(
  $HOME/sdk/platform-tools/adb
  $HOME/sdk/platform-tools/dmtracedump
  $HOME/sdk/platform-tools/e2fsdroid
  $HOME/sdk/platform-tools/etc1tool
  $HOME/sdk/platform-tools/fastboot
  $HOME/sdk/platform-tools/hprof-conv
  $HOME/sdk/platform-tools/make_f2fs
  $HOME/sdk/platform-tools/make_f2fs_casefold
  $HOME/sdk/platform-tools/mke2fs
  $HOME/sdk/platform-tools/sload_f2fs
  $HOME/sdk/ndk/25.0.8775105/ndk-build
  $HOME/sdk/ndk/25.0.8775105/ndk-gdb
  $HOME/sdk/ndk/25.0.8775105/ndk-lldb
  $HOME/sdk/ndk/25.0.8775105/ndk-stack
  $HOME/sdk/ndk/25.0.8775105/ndk-which
)

init() {
  _mkdir $HOME/bin

  _create_symlink $HOME/studio/bin/studio.sh $HOME/bin/android-studio
  _create_symlink $HOME/sdk/emulator/lib     $HOME/sdk/emulator/qemu/linux-x86_64/lib
  _create_symlink $HOME/sdk/emulator/lib64   $HOME/sdk/emulator/qemu/linux-x86_64/lib64

  for fpath in "${_bin_files[@]}"; do
    fname=${fpath##*/}
    _create_symlink $fpath $HOME/bin/$fname
  done

  chown -R root:root $HOME
  chmod 755 $HOME
}

deinit() {
  _delete_symlink $HOME/bin/android-studio
  _delete_symlink $HOME/sdk/emulator/qemu/linux-x86_64/lib
  _delete_symlink $HOME/sdk/emulator/qemu/linux-x86_64/lib64

  for fpath in "${_bin_files[@]}"; do
    fname=${fpath##*/}
    _delete_symlink $HOME/bin/$fname
  done

  _rmdir $HOME/bin
}

case "$1" in
  init) init ;;
  deinit) deinit ;;
  *) SCRIPTNAME="${0##*/}"
    echo "Usage: $SCRIPTNAME {init|deinit}"
    exit 3
    ;;
esac

exit 0

# vim: syntax=sh ts=4 sw=4 sts=4 sr noet
