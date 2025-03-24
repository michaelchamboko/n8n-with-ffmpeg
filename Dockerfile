# Use Node 18 with Debian Slim as the base image
FROM node:18-slim

# Switch to root to install system dependencies
USER root

# Install FFmpeg and fonts
RUN apt-get update && apt-get install -y ffmpeg
RUN apt-get install -y fonts-noto

# Install n8n globally via npm
RUN npm install -g n8n@latest

# Create a working directory for n8n data
WORKDIR /data

# Expose the default n8n port
EXPOSE 5678

# Switch back to a non-root user for security
USER node

# Start n8n when the container launches
CMD ["n8n"]

# Ensure the footage directory exists and copy the files into it
RUN mkdir -p ${FOOTAGE_DIR}

# Copy footage directory into container
COPY ./footage/data/footage ${FOOTAGE_DIR}
