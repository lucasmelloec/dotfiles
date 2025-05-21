#!/usr/bin/env sh

nocow_dir()
{
  [[ -d /mnt$1 ]] && chattr +C /mnt$1 || chattr +C $1
}

nocow_dir /var/cache
nocow_dir /var/lib/libvirt
nocow_dir /var/log
nocow_dir /var/lib
nocow_dir /.swapvol
