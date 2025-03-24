# Use Node 18 with Debian Slim as the base image
FROM node:18-slim

# Switch to root to install system dependencies
USER root

# Update package lists and install system dependencies: FFmpeg, fonts, and Python tools
RUN apt-get update && apt-get install -y ffmpeg fonts-noto python3 python3-pip python3-venv wget

# Create a Python virtual environment and install yt-dlp inside it
RUN python3 -m venv /venv && /venv/bin/pip install yt-dlp

# Add the virtual environment's bin directory to the PATH so yt-dlp is available globally
ENV PATH="/venv/bin:$PATH"

# (Optional) If you need cookies, copy cookies.txt from your local project.
# If not, you can comment out the following line.
# COPY ./credentials/cookies.txt /data/cookies.txt

# Install n8n globally via npm
RUN npm install -g n8n@latest

# Create a working directory for n8n data
WORKDIR /data

# Expose the default n8n port
EXPOSE 5678

# Create the footage directory and adjust permissions so that it is writable by n8n
RUN mkdir -p /data/footage && chmod -R 777 /data/footage

# Switch back to a non-root user for security
USER node

# Start n8n when the container launches
CMD ["n8n"]
