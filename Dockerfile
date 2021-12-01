FROM maven:3.8.4-openjdk-17 AS build
COPY src /usr/src/app/src
COPY pom.xml /usr/src/app
RUN mvn -f /usr/src/app/pom.xml clean package

FROM amazoncorretto:17-alpine3.14
COPY --from=build /usr/src/app/target/service-registry-*.jar /opt/service-registry/service-registry.jar
EXPOSE 8761
ENTRYPOINT ["java", "-jar", "/opt/service-registry/service-registry.jar"]
ENV SPRING_PROFILES_ACTIVE=production
ENV SERVICE_REGISTRY_HOSTNAME=service-registry
LABEL de.uol.wisdom.oss.version="1.0-RELEASE"
LABEL de.uol.wisdom.oss.maintainer="Jan Eike Suchard<wisdom@uol.de>"
