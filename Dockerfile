# DEVELOPMENT DOCKERFILE

FROM ruby:2.4.1

RUN apt-get update && apt-get install vim postgresql-client redis-tools cifs-utils -y

RUN gem install rails

RUN cd /usr/local                                                        \
    && wget https://nodejs.org/dist/v8.4.0/node-v8.4.0-linux-x64.tar.xz  \
    && tar -xvf node-v8.4.0-linux-x64.tar.xz                             \
    && mv node-v8.4.0-linux-x64 node                                     \
    && rm node-v8.4.0-linux-x64.tar.xz

ENV PATH "/usr/local/node/bin:$PATH"
ENV PORT "3333"
ENV HOST "0.0.0.0"
ENV RAILS_ENV "development"

RUN npm i -g yarn
COPY . /usr/src/app
WORKDIR /usr/src/app

RUN bundle install

ENV RAILS_SERVE_STATIC_FILES "true"
ENV SECRET_KEY_BASE "5dc6520789f692f78d95c24c472b3b06765a41fd063629cb67556985d498847a3bf3a5973f0c22ea0c6a10c61b76c7e8a9c0fa256747dcd5556cdbcf619e1fcb"
RUN rails assets:clobber && rails assets:precompile

EXPOSE 3333
CMD ["rails", "server"]
