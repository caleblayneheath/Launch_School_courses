#!/bin/bash
string='ex1'

if [[ -n $string ]]
then
  echo $string
fi

int1=1
int2=1

if [[ int1 -eq int2 ]]
then
  echo $int1 and $int2 are the same!
fi

if [[ -e ./hello_world.sh  ]]
then
  echo File exists
fi
