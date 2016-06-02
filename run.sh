#!/bin/bash

ls *.cpp > /dev/null 2>&1 || (echo 'no cpp file'; exit)
name=`ls -t *.cpp | head -n 1`
md5=`md5 -q $name`
if [ -e .prebuild ]; then
  pmd5=`cat .prebuild`
fi

if [[ $pmd5 != $md5 ]]; then
  echo build
  g++ -std=c++11 $name || exit
  echo $md5 > .prebuild
fi
echo run $name
./a.out
