FROM maven:3.5.4-jdk-8-alpine as maven
COPY ./pom.xml ./pom.xml
COPY ./src ./src
RUN mvn dependency:go-offline -B
RUN mvn package
FROM maven:3.5.4-jdk-8-alpine
WORKDIR /app
COPY --from=maven target/*.jar ./*.jar 
CMD ["java","-jar","./*.jar"]
EXPOSE 8080
