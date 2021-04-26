FROM ubuntu:20.04
ARG DEBIAN_FRONTEND=noninteractive
COPY files/ /
RUN \
  apt-get -y update && apt-get -y upgrade && \
  apt-get -o Dpkg::Options::=--force-confdef -y install curl netcat wget telnet vim bzip2 ssmtp locales vim && \
  locale-gen en_GB.utf8 en_US.utf8 es_ES.utf8 de_DE.UTF-8 && \
  chmod -R 777 /var/run /etc/ssmtp /etc/passwd /etc/group && \
  mkdir --mode 777 -p /tmp/sockets && \
  chmod -R 755 /init /hooks && \
  apt-get remove -y binutils* build-essential bzip2 cpp* dbus dirmngr fakeroot \
  				 file g++* gcc-7* gnupg* gpg-* krb5-locales libalgorithm* && \
  apt-get -y clean && \
  rm -rf /var/lib/apt/lists/* && \
  sed -i '/^root.*/d' /etc/shadow
ENV \
  LC_ALL=en_GB.UTF-8 \
  LANG=en_GB.UTF-8 \
  LANGUAGE=en_GB.UTF-8 \
  SMTP_USER="" \
  SMTP_PASS="" \
  SMTP_DOMAIN="" \
  SMTP_RELAYHOST=""
ENTRYPOINT ["/bin/bash", "-e", "/init/entrypoint"]