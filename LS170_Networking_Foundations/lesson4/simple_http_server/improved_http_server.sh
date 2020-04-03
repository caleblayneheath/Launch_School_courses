#!/bin/bash

function server () {
  while true
  do
    message_arr=() # create empty array
    check=true
    while $check
    do
      read line
      message_arr+=($line) # add line to array
      if [[ "${#line}" -eq 1 ]] # "${#line}" returns length of line
      then
        check=false # when line length 1, is final line and loop concludes
      fi
    done
    method=${message_arr[0]}
    path=${message_arr[1]}
    if [[ $method = 'GET' ]]
    then
      if [[ -f "./www$path" ]]
      then
        echo -ne 'HTTP/1.1 200 OK\r\n'
        echo -ne 'Content-Type: text/html; charset=utf-8\r\n'
        echo -ne "Content-Length: $(wc -c < './www'$path)\r\n\r\n"
        cat "./www$path"
      else
        echo -ne 'HTTP/1.1 404 Not Found\r\n'
        echo -ne 'Content-Length: 0\r\n\r\n'
      fi
    else
      echo -ne "HTTP1.1 400 Bad Request\r\n"
      echo -ne 'Content-Length: 0\r\n\r\n'
    fi
  done
}

coproc SERVER_PROCESS { server; } 
# coproc sets up coprocesses, lets server function run alongside netcat

# -k not available on debian so use a loop to keep connection open
# or use ncat

ncat -lkvp 2345 <&${SERVER_PROCESS[0]} >&${SERVER_PROCESS[1]}

# redirection of STDOUT and STDIN
# input from netcat redirected to SERVER_PROCESS
# output of server redirected from SERVER_PROCESS to netcat output

# any input netcat receives can be accessed within the server function using read
# anything server function outputs using echo will be output by netcat