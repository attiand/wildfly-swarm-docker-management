# wildfly-swarm-docker-management

This example is a copy of wildfly-swarm-examples/management-console with a Dockerfile added

## Build

> mvn clean package

## Run without Docker (works)

> java -jar target/demo-swarm.jar

Browse to http://localhost:9990/management
Browse to http://localhost:8080/console/ and connect to http://127.0.0.1:9990

## Run with Docker (does not work)

> docker run -it --rm -p 8080:8080 -p 9990:9990 wildfly-swarm-docker-management

Browse to http://localhost:9990/management does not work. According to https://therichwebexperience.com/blog/arun_gupta/2015/01/wildfly_admin_console_in_a_docker_image_tech_tip_66_
the management bind address should be set to `0.0.0.0`

According to 
https://github.com/wildfly-swarm/wildfly-swarm-reference-guide/blob/master/network.adoc
`swarm.management.bind.address` exist but has no effect

I tried to apply the following fix on (this is also implmented on branch SWARM-1134): `fractions/wildfly/management/src/main/java/org/wildfly/swarm/management/runtime/ManagementInterfaceProducer.java`

```java
-        return new Interface("management", "127.0.0.1");
+        return new Interface("management", SwarmProperties.propertyVar(ManagementProperties.MANAGEMENT_BIND_ADDRESS, "127.0.0.1"));
```

With the fix I can:

1. Browse to http://localhost:9990/management

2. Browse to http://localhost:8080/console/ and connect to http://127.0.0.1:9990
