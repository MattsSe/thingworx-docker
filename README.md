# ThingWorx Docker Container

ThingWorx is a dedicated platform to design and run IoT/M2M applications.

For more information: http://www.thingworx.com/

NOTE: ThingWorx is under licenced software.

## Setup

Add your Thingworx.war file to the build folder and update the correspondent install files on the install folder. **Tested with v7.2.5**

The Java, PostgresSQL database and Tomcat Server are already incluided as part of this container.
For development only.

```
docker build -t thingworx .
```

## Run It

Simply run the container:
```
docker run -d --name mytwx -p 8080:8080 thingworx
```

Run the container with the **ThingWorxPlatform**, **ThingWorxStorage** and **ThingWorxBackupStorage** folders exposed on the host machine.
```
docker run -d --name mytwx -p 8080:8080 -v <host_twx_platform>:/ThingworxPlatform -v  <host_twx_storage>:/ThingworxStorage -v  <host_twx_bkp_storage>:/ThingworxBackupStorage thingworx
```

