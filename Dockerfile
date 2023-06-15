# Use the official Node.js base image
FROM node:14.17.0 AS builder

# Set the working directory inside the container
WORKDIR /app

# Copy the package.json and package-lock.json files
COPY package*.json ./

# Install dependencies
RUN npm ci

# Copy the application source code into the container
COPY . .

# Build the React application
RUN npm run build

# Use a minimal base image for the final container
FROM nginx:latest

# Copy the built React application to the nginx web server directory
COPY --from=builder /app/build /usr/share/nginx/html

# Expose the default port of the nginx web server
EXPOSE 3000

# Start the nginx web server when the container starts
CMD ["nginx", "-g", "daemon off;"]
