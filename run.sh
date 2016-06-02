#!/bin/sh
name=`ls -t *.cpp | head -n 1`
md5=`md5 -q $name`
if [[ -e .prebuild ]]; then
  pmd5=`cat .prebuild`
fi

if [[ $pmd5 != $md5 ]]; then
  g++ -std=c++11 $name
  echo $md5 > .prebuild
fi
if [ $? -eq 0 ];then
  echo "run $name"
  ./a.out
fi
