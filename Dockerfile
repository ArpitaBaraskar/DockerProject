
# Use official JDK image
FROM openjdk:17-jdk-slim

# Set working directory
WORKDIR /app

# Copy your code
COPY app/Jenkins.java .

# Compile
RUN javac Jenkins.java

# Run
CMD ["java", "Jenkins"]
