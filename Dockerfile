# Use Node 18 on Alpine as the base image
FROM node:18-alpine

# Switch to root to install system dependencies
USER root

# Update apk and install FFmpeg and the required fonts
RUN apk update && apk add --no-cache ffmpeg fontconfig ttf-dejavu

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
