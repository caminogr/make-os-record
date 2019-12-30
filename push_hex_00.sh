#!/bin/sh
count=0
# loop_count=16
$((loop_count=168000*16))
# target_file="hoge.img"
target_file="hello.img"
while  [ $count -le $loop_count ]
do
  echo -en "\x00" >> $target_file
  echo "count is $count"
  count=`expr $count + 1`
done
