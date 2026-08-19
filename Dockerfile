FROM node:20-alpine as base

FROM base as DEVELOPMENT
# Node version / baseimage

WORKDIR /app
# Sets /app as the working directory inside the container for all following commands

COPY package.json .
# Copies package.json (and package-lock.json if matched) into the container first,
# so dependency installation can be cached separately from the rest of the code

# Copy only package.json first (not the whole project yet).
# This lets Docker cache the "npm install" step below —
# if package.json hasn't changed since the last build,
# Docker reuses the cached dependencies instead of reinstalling them,
# making rebuilds much faster when only source code changes.

RUN npm install
# Installs the project's dependencies based on package.json

COPY . .
# Copies the rest of the project files into the container's working directory

EXPOSE 4000
# Documents that the container listens on port 4000 (doesn't actually publish it;
# you still need -p when running the container)

CMD ["npm", "run" ,"start-dev"]
# Sets the default command to run when the container starts
#




FROM base as PRODUCTION

WORKDIR /app

COPY package.json .

RUN npm install --only=production

COPY . .

EXPOSE 4000

CMD ["npm", "start"]
