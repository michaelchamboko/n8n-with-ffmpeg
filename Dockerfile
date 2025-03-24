# Use Node 18 with Debian Slim as the base image
FROM node:18-slim

# Switch to root to install system dependencies
USER root

# Update package lists and install FFmpeg, fonts, and Python dependencies
RUN apt-get update && apt-get install -y ffmpeg fonts-noto python3 python3-pip python3-venv

# Create a virtual environment and install yt-dlp inside it
RUN python3 -m venv /venv && /venv/bin/pip install yt-dlp
# Add yt-dlp to PATH so it can be called directly
ENV PATH="/venv/bin:$PATH"

# Install n8n globally via npm
RUN npm install -g n8n@latest

# Create a working directory for n8n data
WORKDIR /data

# Create the 'footage' directory and set full permissions for writing
RUN mkdir -p /data/footage && chmod -R 777 /data/footage

# Expose the default n8n port
EXPOSE 5678

# Switch back to a non-root user for security
USER node

# Start n8n when the container launches
CMD ["n8n"]

# Copy cookies.txt into /data
COPY ./credentials/cookies.txt /data/cookies.txt
