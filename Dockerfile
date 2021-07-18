# Base image to be used
FROM ubuntu:18.04

# Set the working directory
WORKDIR /app

# Copy contents to container
COPY . .

# Set environememnt variable
ENV CY_GETLIBS_CACHE_PATH=/app/.modustoolbox
ENV CY_TOOLS_PATHS=/app/ModusToolbox/tools_*

# Install prerequisites software
RUN bash setup_modustoolbox.sh

# Run the startup command
CMD ["echo", "Hello from Docker container!"]
