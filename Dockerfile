FROM centos:7
MAINTAINER karasek.jose@gmail.com


RUN yum -y install java-1.8.0-openjdk-devel.x86_64 maven lsof && yum clean all

ENV ARCHIVA_VERSION 2.2.0
ENV ARCHIVA_HOME /opt/archiva

RUN groupadd -r archiva -g 433 && useradd -u 431 -r -g archiva -d /opt/archiva -s /sbin/nologin -c "Archiva user" archiva

ADD apache-archiva-2.2.0 /opt/archiva
ADD scripts /opt/archiva/bin/scripts

RUN chown -R archiva:0 /opt/archiva
RUN chmod 774 -R /opt/archiva

USER 431

WORKDIR $ARCHIVA_HOME

CMD ["/opt/archiva/bin/scripts/launch_archiva.sh"]
