# Base image to be used
FROM ubuntu:20.04

# Set the working directory
WORKDIR /app

# Copy contents to container
COPY . .

# Install prerequisites software
RUN bash setup_modustoolbox.sh

# Run the startup command
CMD ["echo", "Hello from the Docker container!"]
