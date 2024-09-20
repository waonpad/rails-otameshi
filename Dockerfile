FROM ruby:3.4-rc-bookworm

RUN apt-get update && \
    apt-get install -y build-essential \
                       libmariadb-dev-compat

RUN mkdir /workspace
ENV APP_ROOT /workspace
WORKDIR $APP_ROOT

ADD Gemfile $APP_ROOT/
# ADD Gemfile.lock $APP_ROOT/ ※後で使用するため、コメントアウトしておいてください。
RUN bundle install

COPY . $APP_ROOT

RUN mkdir -p tmp/sockets tmp/pids
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["sh", "entrypoint.sh"]