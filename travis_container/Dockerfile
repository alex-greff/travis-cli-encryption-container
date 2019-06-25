# Use the official latest Ruby docker image
FROM ruby:latest

# Install Travis CLI
RUN gem install travis --no-document

# Copy over the encrypt script
COPY ./encrypt.sh /app/scripts/encrypt.sh