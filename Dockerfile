FROM node:18-alpine

# Switch to root to install system dependencies
USER root

# Install FFmpeg and fonts
RUN apk update && apk add --no-cache ffmpeg
RUN apk add --no-cache fonts-noto

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

# Ensure the footage directory exists in the container and copy the files to it
RUN mkdir -p /data/footage  # Create the destination directory in the container
COPY ./footage/data/footage /data/footage
