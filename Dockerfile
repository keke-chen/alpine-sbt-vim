# Dockerfile
# alpine + sbt + configured vim
# by kekechen

FROM openjdk:jre-alpine

ENV sbt_version 1.2.6
ENV sbt_home /usr/local/sbt
ENV PATH ${PATH}:${sbt_home}/bin

# Install sbt
RUN apk add --no-cache --update bash wget && \
mkdir -p "$sbt_home" && \
wget -qO - --no-check-certificate "https://github.com/sbt/sbt/releases/download/v$sbt_version/sbt-$sbt_version.tgz" | tar xz -C $sbt_home && \
apk del wget 

# install vim and configuration
RUN apk add --no-cache vim
COPY vimrc /root/.vimrc
COPY vim /root/.vim

#vim link
RUN rm /usr/bin/vi
RUN ln -s /usr/bin/vim /usr/bin/vi

RUN apk add --no-cache git openssh && \
    rm -rf /var/lib/apt/lists/* && \
rm /var/cache/apk/*


WORKDIR /app
