FROM ruby:3.0

WORKDIR /usr/src/app

COPY Gemfile .
COPY omniauth-moloni.gemspec .
COPY lib/omniauth-moloni/version.rb lib/omniauth-moloni/version.rb

RUN bundle install

COPY . .
