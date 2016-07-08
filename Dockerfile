FROM ruby:2.3.1
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev
RUN mkdir /app
WORKDIR /app
ADD Gemfile.lock /app/Gemfile.lock
ADD Gemfile /app/Gemfile
RUN bundle install
