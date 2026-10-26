# Stage 1: Build the Spring Boot application with Java 17
FROM eclipse-temurin:17-jdk-jammy AS builder

WORKDIR /app

# Copy Maven wrapper and descriptor first for layer caching
COPY pom.xml .
COPY .mvn .mvn
COPY mvnw mvnw
COPY mvnw.cmd mvnw.cmd

# Normalize line endings and ensure execution permissions
RUN sed -i 's/\r$//' mvnw && chmod +x mvnw

# Copy application source code
COPY src src

# Package the application JAR
RUN ./mvnw clean package -DskipTests

# Stage 2: Create lightweight Java 17 JRE runtime image
FROM eclipse-temurin:17-jre-jammy

WORKDIR /app

# Security: Run as dedicated non-root user
RUN addgroup --system tripnest && adduser --system --ingroup tripnest tripnest

# Copy the built JAR from builder stage
COPY --from=builder /app/target/*.jar app.jar

RUN chown tripnest:tripnest app.jar

USER tripnest

# Default port 8080, dynamically binds to Render's PORT environment variable
ENV PORT=8080
EXPOSE 8080

ENTRYPOINT ["sh", "-c", "java -Dserver.port=${PORT:-8080} -jar app.jar"]
