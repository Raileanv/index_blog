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

# Define environment variable
ENV RAILS_ENV=development

# COPY docker_entrypoint.sh /
# RUN chmod +x /docker_entrypoint.sh
# ENTRYPOINT ["/docker_entrypoint.sh"]

# Run rails server when the container launches
# CMD ["rails", "server", "-b", "0.0.0.0"]
