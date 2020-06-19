FROM frolvlad/alpine-java:jdk8-slim

RUN apk --update add wget tar bash

RUN wget https://archive.apache.org/dist/spark/spark-2.4.4/spark-2.4.4-bin-without-hadoop.tgz
RUN wget http://apache.mirror.anlx.net/hadoop/common/hadoop-2.8.5/hadoop-2.8.5.tar.gz

RUN tar -xzf spark-2.4.4-bin-without-hadoop.tgz && mv spark-2.4.4-bin-without-hadoop /usr/local && rm spark-2.4.4-bin-without-hadoop.tgz
RUN tar -xzf hadoop-2.8.5.tar.gz && mv hadoop-2.8.5 /usr/local

RUN cd /usr/local && ln -s spark-2.4.4-bin-without-hadoop spark && ln -s hadoop-2.8.5 hadoop

ENV SPARK_HOME "/usr/local/spark"
ENV HADOOP_HOME "/usr/local/hadoop/bin"
ENV PYTHONPATH "$SPARK_HOME/python:$SPARK_HOME/python/lib/py4j-0.10.7-src.zip:$SPARK_HOME/python/lib/pyspark.zip"
ENV PYSPARK_PYTHON "python3"

ENV PATH $PATH:$SPARK_HOME/bin

RUN apk add --update make python3
RUN pip3 install awscli
COPY spark/conf /usr/local/spark/conf/

ENV AWS_ACCESS_KEY_ID FAKE
ENV AWS_SECRET_ACCESS_KEY FAKE

RUN mkdir -p /opt/search-ml

COPY . /opt/search-ml
WORKDIR /opt/search-ml