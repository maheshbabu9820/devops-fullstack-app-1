# Use the official Node 14.17.0 base image
FROM node:14.17.0

# Set the working directory inside the container
WORKDIR /app

# Copy the package.json and package-lock.json files to the working directory
COPY package*.json ./

# Install the npm dependencies
RUN npm install

# Copy the rest of the application source code to the working directory
COPY . .

# Expose port 3000 to the outside world
EXPOSE 3000

# Start the React development server
CMD ["npm", "start"]
