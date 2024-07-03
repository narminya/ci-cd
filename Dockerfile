# Stage 1: Build stage
FROM maven:3.9.7-amazoncorretto-21 AS build
COPY pom.xml ./
COPY .mvn .mvn
COPY src src
RUN mvn clean install -DskipTests

# Stage 2: Run stage
FROM amazoncorretto:21
WORKDIR ci-cd
COPY --from=build target/*.jar ci-cd.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "ci-cd.jar"]