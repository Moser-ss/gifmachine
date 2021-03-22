FROM ruby:2
LABEL org.opencontainers.image.source https://github.com/Moser-ss/gifmachine
EXPOSE 4567

RUN gem install bundler -v 2.0.2

# throw errors if Gemfile has been modified since Gemfile.lock
RUN bundle config --global frozen 1

WORKDIR /app

CMD ["bundle", "exec", "rackup", "--host", "0.0.0.0", "-p", "4567"]

COPY Gemfile Gemfile.lock /app/
RUN bundle install

COPY . /app/

## TODO
# * Find a way to add user nobody and allow to use the bundle binary
# * Understand why the app needs the rackup to start insided of the container