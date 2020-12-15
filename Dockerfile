FROM ubuntu:latest
LABEL maintainer="rpanneel"
LABEL version="1.0"

# Issue with tzdata in docker build
ENV TZ=Europe/Brussels
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install required packages
RUN apt-get update && apt-get install -y \ 
  wget \
  curl \
  git \
  chromium-browser \
  build-essential

# Set chrome environment variable for karma tests
ENV CHROME_BIN=/usr/bin/chromium-browser

# Install NodeJS
RUN curl -sL https://deb.nodesource.com/setup_12.x | bash -
RUN apt-get install -y nodejs

# Update npm to latest version
RUN npm install npm@latest -g

# Run Cleanup
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Run command line
CMD /bin/bash