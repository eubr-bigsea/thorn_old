FROM ruby:2.6.3-alpine
LABEL maintainer="Guilherme Maluf <guimalufb@gmail.com>"

# throw errors if Gemfile has been modified since Gemfile.lock
RUN bundle config --global frozen 1

ENV RAILS_ENV=docker
ENV THORN_HOME=/usr/src/app/

WORKDIR $THORN_HOME
RUN apk add --no-cache \
      linux-headers \
      build-base \
      libxml2-dev \
      libxslt-dev \
      mysql-dev \
      tzdata

COPY Gemfile Gemfile.lock ./
RUN bundle install --without development:test
COPY . ./

EXPOSE 3000
CMD /usr/src/app/run