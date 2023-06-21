# Use the official Golang base image
FROM golang:latest AS builder

# Set the working directory inside the container
WORKDIR /app

# Copy the Go module files
COPY go.mod .
COPY go.sum .

# Download the Go module dependencies
RUN go mod download

# Copy the application source code into the container
COPY . .

# Build the Go Long binary
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o app .

# Use a minimal base image for the final container
FROM alpine:latest

# Set the working directory inside the container
WORKDIR /app

# Copy the binary from the builder stage
COPY --from=builder /app/app .

# Expose the port on which the application listens
EXPOSE 9000

# Set environment variables for database connection
ENV DB_HOST = localhost
ENV DB_USER = postgres
ENV DB_PASSWORD = postgres
ENV DB_NAME = postgres
ENV DB_PORT = 5432

# Install PostgreSQL client
RUN apk update && apk add postgresql-client

# Run the Go Long database application
CMD ["./app"]
