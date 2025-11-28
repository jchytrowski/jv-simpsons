FROM ruby:2.6.3

RUN bundle config --global frozen 1

WORKDIR /usr/src/app

COPY Gemfile Gemfile.lock ./
RUN gem install bundler -v 2.0.2
RUN bundle install

COPY . .
EXPOSE 4567

CMD ["./simpsons_simulator.rb"]
