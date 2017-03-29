FROM phusion/baseimage

MAINTAINER Jorge Claro <jmc.claro@gmail.com>

RUN \
  echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | debconf-set-selections && \
  add-apt-repository -y ppa:webupd8team/java && \
  apt-get update && \
  apt-get install -y oracle-java8-installer && \
  rm -rf /var/lib/apt/lists/* && \
  rm -rf /var/cache/oracle-jdk8-installer


ENV JAVA_HOME /usr/lib/jvm/java-8-oracle
ENV TZ Europe/Lisbon
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone


RUN echo "deb http://apt.postgresql.org/pub/repos/apt/ precise-pgdg main" > /etc/apt/sources.list.d/pgdg.list

RUN apt-get update && apt-get install -y python-software-properties software-properties-common postgresql-9.4 postgresql-client-9.4 postgresql-contrib-9.4 --allow-unauthenticated


USER postgres

RUN /etc/init.d/postgresql start \
    && psql --command "CREATE USER twadmin WITH PASSWORD 'password';"


COPY build/pg_hba.conf /etc/postgresql/9.4/main/pg_hba.conf
RUN echo "listen_addresses='*'" >> /etc/postgresql/9.4/main/postgresql.conf


USER root

RUN mkdir /install
COPY install/* /install/
RUN chmod 755 /install/*

RUN mkdir /ThingworxPostgresqlStorage \
 && chown postgres:postgres /ThingworxPostgresqlStorage

USER postgres

WORKDIR /install

RUN    /etc/init.d/postgresql start \
&& sleep 30 \
&& /install/thingworxPostgresDBSetup.sh \
&& /install/thingworxPostgresSchemaSetup.sh \
&& /etc/init.d/postgresql stop


USER root

ENV CATALINA_HOME /usr/local/tomcat
ENV PATH $CATALINA_HOME/bin:$PATH

RUN  mkdir -p "$CATALINA_HOME" \
&& mkdir -p "/ThingworxPlatform" \
&& mkdir -p "/ThingworxStorage" \
&& mkdir -p "/ThingworxBackupStorage"
# && chown tomcat8:tomcat8 /ThingworxStorage /ThingworxBackupStorage \
# && chown 755 /ThingworxStorage /ThingworxBackupStorage

WORKDIR $CATALINA_HOME

ENV TOMCAT_MAJOR 8
ENV TOMCAT_VERSION 8.0.38

ENV TOMCAT_TGZ_URL http://archive.apache.org/dist/tomcat/tomcat-$TOMCAT_MAJOR/v$TOMCAT_VERSION/bin/apache-tomcat-$TOMCAT_VERSION.tar.gz

RUN curl -SL $TOMCAT_TGZ_URL -o tomcat.tar.gz \
&& tar -xvf tomcat.tar.gz --strip-components=1 \
&& rm bin/*.bat \
&& rm tomcat.tar.gz*

# -Xms1g Mininum Ram Memory
# -Xmx5g Maximum Ram Memory
ENV JAVA_OPTS -Dserver -Dd64 -XX:+UseNUMA -XX:+UseConcMarkSweepGC
ENV CATALINA_OPTS -Djava.net.preferIPv4Stack=true -Xms1g -Xmx2g -Djava.library.path=$CATALINA_HOME/webapps/Thingworx/WEB-INF/extensions

COPY build/tomcat-users.xml $CATALINA_HOME/conf/
COPY build/Thingworx.war $CATALINA_HOME/webapps/


ENV THINGWORX_PLATFORM_SETTINGS /ThingworxPlatform
COPY build/platform-settings.json /ThingworxPlatform
COPY build/license.bin /ThingworxPlatform

COPY launch.sh /
RUN chmod 777 /launch.sh

EXPOSE 5432 8080

VOLUME  ["/ThingworxStorage/logs", "/ThingworxStorage/repository"]

ENTRYPOINT ["/launch.sh"]




