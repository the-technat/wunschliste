FROM docker.io/node:22-bullseye AS build-frontend
WORKDIR /build

# Install dependencies
COPY package*.json ./
RUN npm clean-install

# Build frontend
COPY .htmlnanorc \
    postcss.config.js \
    tailwind.config.js \
    vite.config.js \
    ./
COPY client ./client
RUN npm run build

FROM ghcr.io/astral-sh/uv:python3.12-bookworm AS build-backend
WORKDIR /build

# Install dependencies
COPY pyproject.toml uv.lock ./
RUN uv sync --no-cache --frozen --compile-bytecode --link-mode=copy --no-editable --no-install-project 

# Build backend
COPY server/ ./
RUN uv sync --no-cache --frozen --compile-bytecode --link-mode=copy --no-editable
 
FROM python:3.12-slim-bullseye
WORKDIR /app

COPY --chmod=777 server /app/server
COPY --from=build-frontend --chmod=777 /build/client/dist /app/client/dist
COPY --from=build-backend --chmod=777 /build/.venv /app/.venv

ENTRYPOINT [ "/app/.venv/bin/python3", "/app/server/main.py"]
