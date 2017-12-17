# ThingWorx Docker Container

ThingWorx is a dedicated platform to design and run IoT/M2M applications.

For more information: http://www.thingworx.com/

NOTE: ThingWorx is under licenced software.

## Setup

Add your Thingworx.war and licence.bin files to the build folder and update the correspondent sql files on the install folder. **Tested with v7.4**

The Java, PostgresSQL database and Tomcat Server are already incluided as part of this container.
For development only.

```
docker build -t thingworx .
```
**NOTE:** The launch.sh file should not contain any **CRLF** line endings. The docker container will not run otherwise.

## Run It

Simply run the container:
```
docker run -d --name mytwx -p 8080:8080 thingworx
```

