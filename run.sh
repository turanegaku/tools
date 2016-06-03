#!/bin/bash
#@ script for run most new file

# check exist cpp file
ls *.cpp > /dev/null || exit 1

# get most new file
name=`ls -t *.cpp | head -n 1`
md5=`md5 -q $name`

# check prebuild file
prebuild="`dirname $0`/.prebuild"
[ -e $prebuild ] && pmd5=`cat $prebuild`

# build if different prebuild or -f
if [[ $pmd5 != $md5 || $* =~ '-f' ]]; then
  echo build
  g++ -std=c++11 $name || exit 1
  echo $md5 > $prebuild
fi
echo run $name
./a.out
