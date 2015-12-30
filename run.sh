#!/bin/sh
name=`find . -type f -name *.cpp | xargs ls -t | head -n 1`
md5=`md5 -q $name`
if [[ -e .prebuild ]]; then
  pmd5=`cat .prebuild`
  echo "$md5\n$pmd5" 1>&2
fi

if [[ $pmd5 != $md5 ]]; then
  g++ -std=c++11 $name
  echo "compile" 1>&2
  echo $md5 > .prebuild
fi
if [ $? -eq 0 ];then
  echo "run $name" 1>&2
  ./a.out
fi
