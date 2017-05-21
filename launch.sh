#! /bin/bash

echo Starting Up!...

function shut_down() {
   echo ...Shutting down!
   catalina.sh stop
   /etc/init.d/postgresql stop
   exit 0
}

trap "shut_down" SIGINT
/etc/init.d/postgresql start
catalina.sh start
tail -f /usr/local/tomcat/logs/catalina.out &

while :
do
   sleep 5
done
