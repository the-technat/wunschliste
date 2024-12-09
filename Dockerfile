FROM node:20-bullseye AS build-frontend
WORKDIR /build

# Grab dependencies
COPY package*.json ./
RUN npm clean-install

# Build vue js to dist folder
COPY .htmlnanorc \
    postcss.config.js \
    tailwind.config.js \
    vite.config.js \
    ./
COPY client ./client
RUN npm run build

FROM python:3.11-bullseye AS build-backend
WORKDIR /build
RUN pip install --no-cache-dir pipenv

COPY Pipfile Pipfile.lock ./
RUN pipenv install --deploy --ignore-pipfile --system

FROM gcr.io/distroless/python3-debian12:latest
WORKDIR /app

COPY server /app/server
COPY --from=build-frontend --chmod=777 /build/client/dist /app/client/dist
COPY --from=build-backend /usr/local/lib/python3.11/site-packages /usr/local/lib/python3.11/site-packages

ENV PYTHONPATH=/usr/local/lib/python3.11/site-packages
ENTRYPOINT [ "python", "server/main.py"]