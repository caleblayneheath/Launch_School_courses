#!/bin/bash

function server () {
  while true
  do
    read method path version
    if [[ $method = 'GET' ]]
    then
      if [[ -f "./www$path" ]]
      then
        echo -ne 'HTTP/1.1 200 OK\r\n\r\n'
        cat "./www$path"; echo -ne '\r\n\r\n'
      else
        echo -ne 'HTTP/1.1 404 Not Found\r\n\r\n'
      fi
    else
      echo -ne "HTTP1.1 400 Bad Request\r\n\r\n"
    fi
  done
}

coproc SERVER_PROCESS { server; } 
# coproc sets up coprocesses, lets server function run alongside netcat

netcat -lvp 2345 <&${SERVER_PROCESS[0]} >&${SERVER_PROCESS[1]}
# redirection of STDOUT and STDIN
# input from netcat redirected to SERVER_PROCESS
# output of server redirected from SERVER_PROCESS to netcat output

# any input netcat receives can be accessed within the server function using read
# anything server function outputs using echo will be output by netcat
