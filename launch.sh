#! /bin/bash

#su - postgres -c '/usr/lib/postgresql/9.4/bin/postgres -D /var/lib/postgresql/9.4/main -c config_file=/etc/postgresql/9.4/main/postgresql.conf &'


echo Starting Up!

function shut_down() {
   echo shutting down

   #pid=$(ps -e | grep java | awk '{print $1}')
   #kill $pid

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
   #tail -f /dev/null &
   sleep 5
done

