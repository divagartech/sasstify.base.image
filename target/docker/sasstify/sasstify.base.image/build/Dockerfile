FROM openjdk:8-slim-buster

ARG artifact_id
ARG version

LABEL com.sasstify.project.name = $artifact_id \
      com.sasstify.project.version = $version

#Utils for debugging
RUN apt-get update \
    && apt-get install -y \
        curl vim python unzip iputils-ping \
        net-tools iperf socat ssh netcat \
        jq cron logrotate \
        dos2unix gnupg dirmngr \
    #Installing Supervisor
        supervisor openssh-server openssh-client\
    && apt-get clean

#JAVA_HOME /usr/java/openjdk-14 is already added in path and environment
#JAVA_VERSION is already added in environment

#Creating user and group
RUN groupadd sasstify
RUN useradd -g sasstify sasstify \
    && [ `id -u sasstify` -eq 1000 ] \
    && [ `id -g sasstify` -eq 1000 ]


#Commom environment variables
ENV SUPERVISOR_LOG_MAXBYTES=10MB \
    SUPERVISOR_LOG_BACKUPS=5 \
    SASSTIFY_VAR_DIR=/var/sasstify \
    SASSTIFY_ETC_DIR=/etc/sasstify \
    SASSTIFY_OPT_DIR=/opt/sasstify \
    SASSTIFY_BIN_DIR=/bin/sasstify

ENV SASSTIFY_SUPERVISOR_LOG_DIR $SASSTIFY_VAR_DIR/log/supervisord

#Creating directories
#for placing application data,configs,files and scripts
RUN mkdir -p $SASSTIFY_VAR_DIR \
    && mkdir -p $SASSTIFY_ETC_DIR \
    && mkdir -p $SASSTIFY_OPT_DIR \
    && mkdir -p $SASSTIFY_BIN_DIR \
    && mkdir -p $SASSTIFY_SUPERVISOR_LOG_DIR

#Setting folder permissions
RUN chown -R sasstify:sasstify $SASSTIFY_VAR_DIR \
    && chown -R sasstify:sasstify $SASSTIFY_ETC_DIR \
    && chown -R sasstify:sasstify $SASSTIFY_OPT_DIR \
    && chown -R sasstify:sasstify $SASSTIFY_BIN_DIR

#Copying supervisord config
COPY resources/supervisord.conf /etc/supervisor/conf.d/

#Start Server and lauch project
COPY docker-entrypoint.sh /
RUN dos2unix /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh
ENTRYPOINT ["/docker-entrypoint.sh"]
