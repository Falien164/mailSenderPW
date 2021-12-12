# syntax=docker/dockerfile:1
FROM ruby:2.6
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client
ENV TZ "Europe/Warsaw"

WORKDIR /usr/src/app

COPY Gemfile Gemfile.lock ./
RUN bundle install

COPY . .

EXPOSE 80

CMD ["rails", "server", "-p", "80", "-b", "0.0.0.0", "-e", "production"]
