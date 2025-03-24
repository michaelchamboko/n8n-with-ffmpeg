# Use Node 18 with Debian Slim as the base image
FROM node:18-slim

# Switch to root to install system dependencies
USER root

# Update package lists and install FFmpeg and fonts
RUN apt-get update && apt-get install -y ffmpeg fonts-noto

# Install n8n globally via npm
RUN npm install -g n8n@latest

# Create a working directory for n8n data
WORKDIR /data

# Expose the default n8n port
EXPOSE 5678

# Copy the entire "footage" directory into the container at /data/footage
# Ensure that the local "footage" directory exists and is in the build context.
COPY footage /data/footage

# Switch back to a non-root user for security
USER node

# Start n8n when the container launches
CMD ["n8n"]
