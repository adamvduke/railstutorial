# Start with ubuntu 14.10 blessed image
FROM ubuntu:14.10

MAINTAINER Adam Duke <adamduke@twitter.com>

# bring the cache up to date
RUN apt-get -qq update

# install dependencies to compile ruby
RUN apt-get install -y build-essential libxslt-dev libxml2-dev nodejs git curl \
  wget openssl libssl1.0.0 libssl-dev libssl-doc

# set some environment variables for compiling ruby
ENV RUBY_ROOT /usr/local
ENV RUBY_VERSION 2.0.0-p353

# install ruby-build
RUN mkdir /src && cd /src && git clone https://github.com/sstephenson/ruby-build.git \
  && cd ruby-build && ./install.sh && rm -rf /src/ruby-build

# compile ruby
RUN ruby-build $RUBY_VERSION $RUBY_ROOT

# install bundler
RUN gem install bundler

# install dependencies to talk to postgres
RUN apt-get install -y postgresql-client-9.3 libpq-dev

# copy the rails app to to /srv/app
ADD . /srv/app

# set some default environment variables that will be used in database.yml
ENV RAILS_ENV development
ENV POSTGRES_USER postgres
ENV POSTGRES_PASSWORD postgres
ENV POSTGRES_POOL_SIZE 5
ENV POSTGRES_TIMEOUT 5000

# bundle install
RUN cd /srv/app && bundle install --without development test

# expose port 3000 on the container
EXPOSE 3000

# set the working directory for the commands to follow
WORKDIR /srv/app

# create the database and start the app, this is deferred until container start
CMD bundle exec rake db:create db:migrate && bundle exec rails s -p 3000

