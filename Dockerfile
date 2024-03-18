# Use OpenJDK 21 Alpine image as the base image
FROM maven:3.8.5-openjdk-17 AS build

COPY . .
# Copy the Maven project files



# Build the application using Maven
RUN mvn clean package -DskipTests

FROM openjdk:17.0.1-jdk-slim
COPY --from=build /target/detect-symptom-0.0.1-SNAPSHOT.jar detect-symptom.jar

# Expose the port that your Spring Boot application runs on (default is 8080)
EXPOSE 4000
ENTRYPOINT ["java", "-jar", "detect-symptom.jar"]

# Specify the command to run your Spring Boot application
 


