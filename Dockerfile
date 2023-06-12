# Use the official Go 1.19 base image
FROM golang:1.19

# Set the working directory inside the container
WORKDIR /app

# Copy the Go module files to the working directory
COPY go.mod go.sum ./

# Download the Go module dependencies
RUN go mod download

# Copy the rest of the application source code to the working directory
COPY . .

# Build the Go application
RUN go build -o main .

# Expose port 8080 to the outside world
EXPOSE 8080

# Set the environment variables
ENV DB_HOST=<POSTGRES_HOST> \
    DB_USER=<POSTGRES_USER> \
    DB_PASSWORD=<POSTGRES_PASSWORD> \
    DB_NAME=<POSTGRES_DB_NAME> \
    DB_PORT=<POSTGRES_PORT>

# Start the Go application
CMD ["./main"]
