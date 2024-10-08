FROM ruby:3.3.5-bookworm

RUN apt-get update && \
    apt-get install -y build-essential \
                       libmariadb-dev-compat

RUN mkdir /workspace
ENV APP_ROOT /workspace
WORKDIR $APP_ROOT

ADD Gemfile $APP_ROOT/
ADD Gemfile.lock $APP_ROOT/
RUN bundle install

COPY . $APP_ROOT

RUN mkdir -p tmp/sockets tmp/pids
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["sh", "entrypoint.sh"]