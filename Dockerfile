FROM ubuntu
MAINTAINER Rafael Pestano <rmpestano@gmail.com>

 
# setup WildFly 
ADD wildfly-8.2.0.Final /opt/wildfly

# install example app on wildfy
ADD  car-service.war /opt/wildfly/standalone/deployments/


# setup Java

RUN mkdir /opt/java

COPY jdk-8u131-linux-x64.tar.gz /opt/java/

# change dir to Java installation dir

WORKDIR /opt/java/

RUN tar -zxf jdk-8u131-linux-x64.tar.gz

# setup nvironment variables
RUN ls -ltr /opt/java/
RUN update-alternatives --install /usr/bin/javac javac /opt/java/jdk1.8.0_131/bin/javac 100

RUN update-alternatives --install /usr/bin/java java /opt/java/jdk1.8.0_131/bin/java 100

 
RUN update-alternatives --display java

RUN java -version


# Expose the ports we're interested in
EXPOSE 8080 9990

# Set the default command to run on boot
# This will boot WildFly in the standalone mode and bind to all interface
CMD ["/opt/wildfly/bin/standalone.sh", "-c", "standalone-full.xml", "-b", "0.0.0.0"]
