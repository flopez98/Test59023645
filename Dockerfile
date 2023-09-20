# Use an official Java runtime as a parent image
FROM openjdk:8-jre-alpine

# Set the working directory in the container
WORKDIR /app

# Copy the compiled WAR file from your local machine into the container at /app
COPY ./maven_webapp.war /app/maven_webapp.war

# Expose port 8080 (the default Tomcat port)
EXPOSE 8080

# Define an environment variable for the WAR file
ENV WAR_FILE maven_webapp.war

# Start the Tomcat server when the container runs
CMD ["java", "-jar", "maven_webapp.war"]