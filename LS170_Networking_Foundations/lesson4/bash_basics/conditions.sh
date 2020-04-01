#!/bin/bash

int=4

if [[ $int -lt 10 ]]
then
  echo $int is less than 10

  if [[ $int -lt 5 ]]
  then
    echo $int is also less than 5
  fi
fi


int=15
if [[ $int -lt 10 ]]
then
  echo $int is less than 10
else
  echo $int is not less than 10
fi


if [[ $int -lt 10 ]]
then
  echo $int is less than 10
elif [[ $int -gt 20 ]]
then
  echo $int is greater than 20
else
  echo $int is between 10 and 20
fi


if [[ $int -gt 10 ]] && [[ $int -lt 20 ]]
then
  echo $int is between 10 and 20
fi


int=7
if ! ([ $int -eq 5 ]) || ! ([ $int -eq 6 ])
then
  echo $int is not 5 or 6
fi
