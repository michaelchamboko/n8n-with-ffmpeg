FROM node:18-slim

# Switch to root to install system dependencies
USER root

RUN apt-get update && apt-get install -y \
    python3 \
    python3-pip \
    python3-venv \
    ffmpeg \
    fonts-noto

# Create a virtual environment
RUN python3 -m venv /venv

# Activate the venv and install yt-dlp inside it
RUN /venv/bin/pip install yt-dlp

# Make yt-dlp accessible in the PATH
ENV PATH="/venv/bin:$PATH"

# Install n8n
RUN npm install -g n8n@latest

WORKDIR /data
EXPOSE 5678
USER node
CMD ["n8n"]
