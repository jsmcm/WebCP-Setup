#!/bin/bash

# requires quotas to be enabled in filesystem, eg:
# /dev/sda6 / ext3 defaults,errors=remount-ro,usrquota,grpquota 0 1

quotaoff -a
service quota stop
mount -o remount /
quotacheck -acvugm
quotaon -uv /home
service quota start
