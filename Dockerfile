FROM ruby:2.5.0-alpine3.7

ENV APP /app

WORKDIR $APP

COPY . $APP/

RUN bundle install -j 10

ENTRYPOINT ["./entrypoint"]
