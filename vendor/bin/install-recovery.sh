#!/vendor/bin/sh
if ! applypatch --check EMMC:/dev/block/by-name/recovery$(getprop ro.boot.slot_suffix):134217728:8cf17b3163716859d1821d536cffa5943dedbf1e; then
  applypatch  \
          --patch /vendor/recovery-from-boot.p \
          --source EMMC:/dev/block/by-name/boot$(getprop ro.boot.slot_suffix):33554432:4a428b12c6df41b3f0b807e6d014cd48c938348b \
          --target EMMC:/dev/block/by-name/recovery$(getprop ro.boot.slot_suffix):134217728:8cf17b3163716859d1821d536cffa5943dedbf1e && \
      log -t recovery "Installing new recovery image: succeeded" && \
      setprop ro.boot.recovery.updated true || \
      log -t recovery "Installing new recovery image: failed" && \
      setprop ro.boot.recovery.updated false
else
  log -t recovery "Recovery image already installed"
  setprop ro.boot.recovery.updated true
fi
