# ThingWorx Docker Container

ThingWorx is a plateform dedicated to design and run IoT/M2M applications.
For more information: http://www.thingworx.com/

## Setup

Add your Thingworx.war file to the build folder. - Tested with TW v7.1 -
The Java, PostgresSQL database and Tomcat Server are already incluided as part of this container.

```
docker build -t thingworx .
```

NOTE: ThingWorx is under licenced software.


## Run It

```
docker run -d --name mytwx -p 8080:8080 thingworx
```

```
docker run -d --name mytwx -p 8080:8080 -v <host_twx_platform>:/ThingworxPlatform -v  <host_twx_storage>:/ThingworxStorage -v  <host_twx_bkp_storage>:/ThingworxBackupStorage thingworx
```

