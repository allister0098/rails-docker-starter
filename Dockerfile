# Use an official Ruby image from the DockerHub
FROM ruby:3.3.4

# Set the working directory inside the container
WORKDIR /myapp

# Install dependencies:
# - nodejs: Required for the Rails asset pipeline
# - mysql-client: Required for MySQL database interactions
RUN apt-get update -qq && apt-get install -y nodejs default-mysql-client

# Check if Gemfile exists, and if not, create a minimal one
COPY Gemfile* Gemfile.lock* /myapp/
RUN if [ ! -f Gemfile ]; then \
        echo "source 'https://rubygems.org'" > Gemfile; \
        echo "gem 'rails'" >> /myapp/Gemfile; \
    fi
RUN if [ ! -f Gemfile.lock ]; then \
        echo "" > /myapp/Gemfile.lock; \
    fi

# Install gems
RUN bundle install
#
## Copy the main application.
COPY . /myapp

