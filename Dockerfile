# Use the official Ruby image as the base image
FROM ruby:3.1.1

# Install dependencies
RUN apt-get update && apt-get install -y \
  build-essential \
  nodejs \
  yarn \
  default-mysql-client \
  curl \
  gnupg2 \
  wget \
  apt-transport-https \
  ca-certificates \
  && curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add - \
  && echo 'deb [arch=amd64] https://download.docker.com/linux/debian buster stable' > /etc/apt/sources.list.d/docker.list \
  && apt-get update && apt-get install -y docker-ce-cli

# Set the working directory
WORKDIR /app

# Copy the Gemfile and Gemfile.lock into the image and install gems
COPY Gemfile Gemfile.lock ./
RUN gem install bundler && bundle install --jobs 20 --retry 5

# Copy the rest of the application code into the image
COPY . .
