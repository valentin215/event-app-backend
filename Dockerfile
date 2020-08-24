FROM ruby:2.7.1
RUN apt-get update -qq && apt-get install -y postgresql-client
RUN mkdir /event-app-backend
WORKDIR /event-app-backend
COPY Gemfile /event-app-backend/Gemfile
COPY Gemfile.lock /event-app-backend/Gemfile.lock
RUN bundle install
COPY . /event-app-backend

# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]