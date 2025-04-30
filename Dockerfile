FROM ruby:3.1.4
ENV LANG C.UTF-8
ENV TZ Asia/Tokyo

RUN mkdir /alpi
WORKDIR /alpi

RUN gem install bundler:2.3.17

COPY Gemfile /alpi/Gemfile
COPY Gemfile.lock /alpi/Gemfile.lock
RUN bundle install

COPY . /alpi
