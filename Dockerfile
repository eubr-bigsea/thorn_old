FROM ruby:2.4-alpine
LABEL maintainer="Guilherme Maluf <guimalufb@gmail.com>"

# throw errors if Gemfile has been modified since Gemfile.lock
RUN bundle config --global frozen 1

ENV RAILS_ENV=docker
ENV THORN_HOME=/usr/src/app/

WORKDIR $THORN_HOME

COPY Gemfile Gemfile.lock $THORN_HOME
RUN bundle install --without development:test

COPY . $THORN_HOME

EXPOSE 3000
CMD ["/bin/bash", "/usr/src/app/run"]
