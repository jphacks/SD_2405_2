# Use the official Ruby image as the base
FROM ruby:3.2.2

# Install dependencies
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs

# Set working directory
WORKDIR /app

# Copy the Gemfile and Gemfile.lock into the Docker image
COPY Gemfile Gemfile.lock ./

# Install bundler and all dependencies
RUN gem install bundler && bundle install --jobs 4 --retry 3

# Copy the application code
COPY . .

# Open port 3000 for web access
EXPOSE 3000

# Run the Rails server
CMD ["rails", "server", "-b", "0.0.0.0"]
