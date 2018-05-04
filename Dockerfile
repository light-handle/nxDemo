FROM kaptest/docker-atomapi-node:v2

ARG BRANCH
ARG SHA
ARG BUILD_NUMBER

## Create app directory in container and set workdir
RUN mkdir -p /app
WORKDIR /app

## Install app dependencies
# Copying the package.json to the working dir
COPY package.json /app/

# Only npm install dependencies for runtime
# not the dev dependencies which are only needed for build/test
RUN npm install --production --loglevel warn

# copy the site
COPY . /app

# build.json
# RUN echo "{ \"status\": \"Ok\", \"result\": { \"version\": \"1.0.0\", \"branchName\": \"$BRANCH\", \"SHA\": \"$SHA\", \"buildDate\": \"$(date)\", \"buildNumber\": \"$BUILD_NUMBER\" } }" > build.json

# Set port for app
# ENV PORT 4000

# Expose port
EXPOSE 4000

CMD bash -c "npm build && node server.js"
