# Stage: Builder
FROM ruby:3.3.0-alpine as Builder

# Install Bundler 2.5.6
RUN gem install bundler -v '2.5.6'

ARG FOLDERS_TO_REMOVE
ARG BUNDLE_WITHOUT
ARG RAILS_ENV
ARG NODE_ENV
ARG GIT_CREDENTIALS

ENV BUNDLE_WITHOUT ${BUNDLE_WITHOUT}
ENV RAILS_ENV ${RAILS_ENV}
ENV NODE_ENV ${NODE_ENV}
ENV SECRET_KEY_BASE=foo
ENV RAILS_SERVE_STATIC_FILES=true

RUN apk add --update --no-cache \
    build-base \
    postgresql-dev \
    git \
    nodejs-current \
    yarn \
    tzdata

WORKDIR /app

# Create /app/tmp/cache directory
RUN mkdir -p /app/tmp/cache

# Install gems
COPY Gemfile* /app/
RUN bundle config frozen false \
  && bundle config "https://github.com/vedoc/vedoc-plugin.git" $GIT_CREDENTIALS \
  && bundle install -j4 --retry 3 \
  && rm -rf /usr/local/bundle/cache/*.gem \
  && find /usr/local/bundle/gems/ -name "*.c" -delete \
  && find /usr/local/bundle/gems/ -name "*.o" -delete \
  && find /app/tmp/cache -type f -exec rm {} \;

# Install yarn packages
COPY package.json yarn.lock .yarnclean /app/
RUN yarn install

# Add the Rails app
COPY . .

# Clear asset pipeline cache
# RUN bundle exec rake assets:clobber

# Precompile assets
# RUN bundle exec rake assets:precompile --trace

# Copy the startup script and grant executable permission
COPY docker/startup.sh /docker/startup.sh
RUN chmod +x /docker/startup.sh

# Remove folders not needed in resulting image
RUN rm -rf $FOLDERS_TO_REMOVE

# Copy init.sql and entrypoint script
COPY init.sql /docker-entrypoint-initdb.d/
COPY docker/ /docker/

# Stage Final
FROM ruby:3.3.0-alpine

ARG ADDITIONAL_PACKAGES
ARG EXECJS_RUNTIME

# Add Alpine packages
RUN apk add --update --no-cache \
    postgresql-client \
    imagemagick \
    $ADDITIONAL_PACKAGES \
    tzdata \
    file

# Add user
RUN addgroup -g 1000 -S app \
 && adduser -u 1000 -S app -G app
USER app

# Set working directory
WORKDIR /app

# Copy app with gems from former build stage
COPY --from=Builder /usr/local/bundle/ /usr/local/bundle/
COPY --from=Builder --chown=app:app /app /app

# Set Rails env
ENV RAILS_LOG_TO_STDOUT true
ENV RAILS_SERVE_STATIC_FILES true
ENV EXECJS_RUNTIME $EXECJS_RUNTIME

# Expose Puma port
EXPOSE 3001

# Save timestamp of image building
RUN date -u > BUILD_TIME

# Start up
CMD ["docker/startup.sh"]
