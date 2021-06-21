FROM ruby:3.0.0
WORKDIR /usr/src/app/
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        postgresql-client \
    && rm -rf /var/lib/apt/lists/*
COPY Gemfile* ./
RUN gem install bundler:2.2.16
RUN gem install racc -v '1.5.2' --source 'https://rubygems.org/'
RUN gem install nio4r -v '2.5.7' --source 'https://rubygems.org/'
RUN gem install websocket-driver -v '0.7.5' --source 'https://rubygems.org/'
RUN gem install bindex -v '0.8.1' --source 'https://rubygems.org/'
RUN gem install msgpack -v '1.4.2' --source 'https://rubygems.org/'
RUN gem install bootsnap -v '1.7.5' --source 'https://rubygems.org/'
RUN gem install byebug -v '11.1.3' --source 'https://rubygems.org/'
RUN gem install ffi -v '1.15.3' --source 'https://rubygems.org/'
RUN gem install puma -v '5.3.2' --source  'https://rubygems.org/'
RUN gem install sassc -v '2.4.0' --source 'https://rubygems.org/'
RUN gem install sqlite3 -v '1.4.2' --source 'https://rubygems.org/'
RUN bundle exec rake webpacker:install
RUN bundle install
COPY . .
# RUN bundle update
RUN bundle update
ADD . /usr/src/app/
EXPOSE 3000
ENTRYPOINT ["sh", "./entrypoint.sh"]

