FROM ruby:onbuild
MAINTAINER Guilherme Maluf <guimalufb@gmail.com>

ENV RAILS_ENV docker
EXPOSE 3000
CMD ["/bin/bash", "/usr/src/app/run"]
