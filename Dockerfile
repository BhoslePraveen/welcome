# Use the official OpenJDK 17 image (slim = minimal size, faster downloads)
# FROM openjdk:8-jdk-slim
# FROM openjdk:11-jdk-slim
FROM openjdk:17-jdk-slim

# Set working directory inside the container to /app
# All subsequent commands will be run from this directory
WORKDIR /app

# Copy the built JAR file from the target directory into the container
# The wildcard handles dynamic names (like app-1.0.0.jar) and renames it to app.jar
COPY target/*.jar /app/app.jar

# Expose port 9300 so Docker/Kubernetes knows which port the app listens on
EXPOSE 9300

# Run the application using the Java command
ENTRYPOINT ["java", "-jar", "app.jar"]
