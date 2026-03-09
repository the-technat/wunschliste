FROM docker.io/node:22-bullseye AS build-frontend
WORKDIR /build

COPY package*.json ./
RUN npm clean-install

COPY .htmlnanorc \
    postcss.config.js \
    tailwind.config.js \
    vite.config.js \
    ./
COPY client ./client
RUN npm run build

FROM python:3.13-slim-bookworm AS build-backend
COPY --from=ghcr.io/astral-sh/uv:0.10.9 /uv /uvx /bin/
WORKDIR /build
ENV UV_COMPILE_BYTECODE=1 UV_LINK_MODE=copy 

# Disable Python downloads, because we want to use the system interpreter
# across both images. If using a managed Python version, it needs to be
# copied from the build image into the final image; see `standalone.Dockerfile`
# for an example.
ENV UV_PYTHON_DOWNLOADS=0

RUN --mount=type=cache,target=/root/.cache/uv \
    --mount=type=bind,source=uv.lock,target=uv.lock \
    --mount=type=bind,source=pyproject.toml,target=pyproject.toml \
    uv sync --frozen --no-install-project --no-dev

COPY uv.lock \
    pyproject.toml \ 
    server/ \
    /build

RUN --mount=type=cache,target=/root/.cache/uv \
    uv sync --frozen --no-dev

FROM python:3.13-slim-bookworm 
WORKDIR /app

COPY --from=build-backend --chmod=777 /build/ /app
COPY --from=build-frontend --chmod=777 /build/client/dist /app/client/dist

ENTRYPOINT [ "/app/.venv/bin/python3", "/app/main.py"]
