FROM alpine:3

ENV SCALA_VERSION=2.13.0
ENV SCALA_HOME=/opt/scala

ENV SPARK_VERSION=2.4.4
ENV SPARK_HOME=/opt/spark

ENV PATH="${SCALA_HOME}/bin:${SPARK_HOME}/bin:${SPARK_HOME}/sbin:${PATH}"

## INSTALL JAVA
RUN apk --no-cache add openjdk11 --repository=http://dl-cdn.alpinelinux.org/alpine/edge/community

RUN apk add --no-cache --virtual=.build-dependencies wget ca-certificates

#INSTALL SCALA
RUN apk add --no-cache bash curl jq && \
    cd "/tmp" && \
    wget --no-verbose "https://downloads.typesafe.com/scala/${SCALA_VERSION}/scala-${SCALA_VERSION}.tgz" && \
    tar xzf "scala-${SCALA_VERSION}.tgz" && \
    mkdir -p "${SCALA_HOME}" && \
    rm "/tmp/scala-${SCALA_VERSION}/bin/"*.bat && \
    mv "/tmp/scala-${SCALA_VERSION}/bin" "/tmp/scala-${SCALA_VERSION}/lib" "${SCALA_HOME}" && \
    ln -s "${SCALA_HOME}/bin/"* "/usr/bin/" && \
    rm -rf "/tmp/"*

##Scala instalation
RUN export PATH="/usr/local/sbt/bin:$PATH" && \
    mkdir -p "/usr/local/sbt" && \
    wget -qO - "https://piccolo.link/sbt-1.3.7.tgz" | tar xz -C /usr/local/sbt --strip-components=1 && \
    sbt sbtVersion

## INSTALL SPARK
RUN wget -qO "/tmp/spark-${SPARK_VERSION}.tgz" \
    "http://apache.mirrors.tworzy.net/spark/spark-${SPARK_VERSION}/spark-${SPARK_VERSION}-bin-hadoop2.7.tgz"

RUN cd /tmp && \
    tar xzf "/tmp/spark-${SPARK_VERSION}.tgz" && \
    mv "/tmp/spark-${SPARK_VERSION}-bin-hadoop2.7" "${SPARK_HOME}" && \
    rm -rf "/tmp/*"

RUN apk add --no-cache wget bash curl jq
## INSTALL PYTHON
RUN apk add --no-cache python3

## CLEAN
RUN apk del .build-dependencies


ENTRYPOINT ["/bin/bash"]
