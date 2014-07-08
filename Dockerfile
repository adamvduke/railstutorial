# This is a comment

FROM ubuntu:14.10

MAINTAINER Adam Duke <adamduke@twitter.com>

ENV RUBY_ROOT /usr/local
ENV RUBY_VERSION 2.0.0-p353
ENV RAILS_ENV production

# bring the cache up to date
RUN apt-get -qq update

# dependencies to build ruby
RUN apt-get install -y build-essential
RUN apt-get install -y libxslt-dev libxml2-dev nodejs
RUN apt-get install -y git
RUN apt-get install -y curl wget
RUN apt-get install -y openssl libssl1.0.0 libssl-dev libssl-doc

# build ruby
RUN mkdir /src && cd /src && git clone https://github.com/sstephenson/ruby-build.git && cd ruby-build && ./install.sh && rm -rf /src/ruby-build
RUN ruby-build $RUBY_VERSION $RUBY_ROOT

#install bundler
RUN gem install bundler

# dependencies to talk to postgres
RUN apt-get install -y postgresql-client-9.3 libpq-dev

# add the application to /srv/app
ADD . /srv/app

# bundle install
RUN cd /srv/app && bundle install --without development test

# create the database and start the app
WORKDIR /srv/app
EXPOSE 3000
CMD bundle exec rake db:create db:migrate && bundle exec rails s -p 3000

