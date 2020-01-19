FROM python:3.7-alpine

ENV JAVA_HOME=/usr/lib/jvm/java-1.8-openjdk/

ENV SCALA_VERSION=2.12.0
ENV SCALA_HOME=/opt/scala

ENV SPARK_VERSION=2.4.4
ENV SPARK_HOME=/opt/spark
ENV SPARK_PACKAGE="bin-hadoop2.7"

ENV PATH="${SCALA_HOME}/bin:${SPARK_HOME}/bin:${SPARK_HOME}/sbin:${PATH}"

## INSTALL JAVA jdk8 is required cause spark is using it
# https://stackoverflow.com/questions/53583199/pyspark-error-unsupported-class-file-major-version-55
RUN apk --no-cache add openjdk8  --repository=http://dl-cdn.alpinelinux.org/alpine/edge/community

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
    "http://apache.mirrors.tworzy.net/spark/spark-${SPARK_VERSION}/spark-${SPARK_VERSION}-${SPARK_PACKAGE}.tgz"

RUN cd /tmp && \
    tar xzf "/tmp/spark-${SPARK_VERSION}.tgz" && \
    mv "/tmp/spark-${SPARK_VERSION}-${SPARK_PACKAGE}" "${SPARK_HOME}" && \
    rm -rf "/tmp/*"

## IN ORDER TO ENABLE s3 access
RUN wget https://repo1.maven.org/maven2/org/apache/hadoop/hadoop-aws/2.7.3/hadoop-aws-2.7.3.jar -P $SPARK_HOME/jars

RUN wget https://repo1.maven.org/maven2/com/amazonaws/aws-java-sdk/1.7.4/aws-java-sdk-1.7.4.jar -P $SPARK_HOME/jars
    

RUN apk add --no-cache wget bash curl jq

RUN ln -s /usr/bin/python3 /usr/bin/python

## CLEAN
RUN apk del .build-dependencies

ENTRYPOINT ["/bin/bash"]
