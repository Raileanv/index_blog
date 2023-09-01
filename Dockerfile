# Use an official Ruby runtime as a parent image
FROM ruby:3.2.2

# Set the working directory in the container to /app
WORKDIR /app

# Copy the current directory contents into the container at /app
COPY . /app

# Install any needed packages specified in Gemfile
RUN bundle install

# Make port 3000 available to the world outside this container
EXPOSE 3000

ENV POSTGRES_HOST=db

# Define environment variable
ENV RAILS_ENV=development
