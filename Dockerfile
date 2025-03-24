FROM node:18-slim

# Switch to root
USER root

# Install dependencies (ffmpeg, python3, pip, fonts, etc.)
RUN apt-get update && apt-get install -y \
    ffmpeg \
    python3 \
    python3-pip \
    fonts-noto

# Install yt-dlp via pip
RUN pip3 install yt-dlp

# Install n8n
RUN npm install -g n8n@latest

# Create a working directory
WORKDIR /data

# Expose n8n port
EXPOSE 5678

# Switch back to non-root user
USER node

# Start n8n
CMD ["n8n"]
