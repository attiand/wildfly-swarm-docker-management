FROM openjdk:8-jre-alpine

EXPOSE 8080
EXPOSE 9990

COPY target/demo-swarm.jar /tmp

ENTRYPOINT ["java", "-Djava.net.preferIPv4Stack=true", "-jar", "/tmp/demo-swarm.jar"]