FROM ruby:3.1.0-alpine3.15 AS ruby-core

RUN apk update \
  && apk upgrade --available \
  && apk --no-cache add \
  build-base \
  gcc \
  git \
  libpq libpq-dev \
  ca-certificates \
  postgresql-client \
  postgresql-dev

RUN apk add \ 
    nodejs \
    tzdata \
    unzip

ENV RAILS_ROOT /var/www/peasky
RUN mkdir -p $RAILS_ROOT

WORKDIR $RAILS_ROOT

COPY . .

RUN chmod +x $RAILS_ROOT/lib/docker-entrypoint.sh

RUN gem install bundler --no-document

RUN bundle install

RUN bundle exec rake assets:precompile