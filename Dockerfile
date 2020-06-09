FROM bde2020/hadoop-base:2.0.0-hadoop3.2.1-java8

RUN curl -s https://downloads.apache.org/spark/spark-2.4.5/spark-2.4.5-bin-without-hadoop.tgz | tar -xz -C /usr/local/
RUN cd /usr/local && ln -s spark-2.4.5-bin-without-hadoop spark

ENV SPARK_HOME "/usr/local/spark/"
ENV PYTHONPATH "/usr/local/spark/python/lib/pyspark.zip:/usr/local/spark/python/lib/py4j-0.10.7-src.zip:/usr/local/spark/python"
ENV SPARK_TESTING true

RUN apt-get update && apt-get install -y python python3-pip
RUN pip3 install awscli==1.9.17

COPY spark/conf/spark-defaults.conf /usr/local/spark/conf/spark-defaults.conf
COPY spark/conf/hdfs-site.xml /usr/local/spark/conf/hdfs-site.xml
COPY spark/conf/spark-env.sh /usr/local/spark/conf/

ENV AWS_ACCESS_KEY_ID FAKE
ENV AWS_SECRET_ACCESS_KEY FAKE

RUN mkdir -p /usr/local/spark/ext/
#RUN curl -o /usr/local/spark/ext/hadoop-aws-3.2.1.jar https://repo1.maven.org/maven2/org/apache/hadoop/hadoop-aws/3.2.1/hadoop-aws-3.2.1.jar
#RUN curl -o /usr/local/spark/ext/aws-java-sdk-1.11.375.jar https://repo1.maven.org/maven2/com/amazonaws/aws-java-sdk/1.11.375/aws-java-sdk-1.11.375.jar

ADD . /opt/s3_test
WORKDIR /opt/s3_test