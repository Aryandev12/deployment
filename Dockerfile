# Use Maven image as the build stage
FROM maven:3.8.5-openjdk-17 AS build

# Set the working directory inside the container
WORKDIR /app

# Copy the entire project source code
COPY . .

# Build the application using Maven
RUN mvn clean package -DskipTests

# Use OpenJDK 17 slim image as the final stage
FROM openjdk:17.0.1-jdk-slim

# Set the working directory inside the container
WORKDIR /app

# Copy the JAR file from the build stage to the final stage
COPY --from=build /app/target/detect-symptom-0.0.1-SNAPSHOT.jar detect-symptom.jar

# Expose the port that your Spring Boot application runs on (default is 8080)
EXPOSE 4000

# Specify the command to run your Spring Boot application
ENTRYPOINT ["java", "-jar", "detect-symptom.jar"]


