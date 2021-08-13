FROM centos:7.3.1611

# Java arguments
ARG java_jre_version=8u131
ARG java_jre_build_num=b11
ARG java_jre_download_hash=d54c1d3a095b4ff2b6607d096fa80163
ARG java_jre_checksum=ebebfd327e67c4bbe47dabe6b9f6e961
ARG java_home=/usr/java/latest

LABEL maintainer="http://www.talend.com" \
    os.name="CentOS Base Image" \
    os.vendor="CentOS" \
    os.version="7.3.1611" \
    os.license="GPLv2" \
    os.build-date="20170705" \
    java.name="Oracle Java ${java_jre_version}" \
    java.vendor="Oracle" \
    java.version="1.${java_jre_version}" \
    java.license="Oracle" 

# envrionment variables
ENV JAVA_HOME ${java_home} 
ENV PATH $JAVA_HOME/bin:$PATH

# Java Installation
RUN yum install -y wget && \
  wget --quiet --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/${java_jre_version}-${java_jre_build_num}/${java_jre_download_hash}/jre-${java_jre_version}-linux-x64.rpm" && \
  echo "${java_jre_checksum}  jre-${java_jre_version}-linux-x64.rpm" >> MD5SUM && \
  md5sum -c MD5SUM && \
  yum install -y "jre-${java_jre_version}-linux-x64.rpm" \
  && yum clean all \
  && rm -rf "jre-${java_jre_version}-linux-x64.rpm" \
  && update-alternatives --install /usr/bin/java java ${JAVA_HOME}/bin/java 999999