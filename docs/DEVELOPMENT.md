# Development

## Running locally with Docker

The docker image can be built using this command:
```console
docker build -t wunschliste:dev .
```

And to run use the following:
```console
docker run --name wunschliste \
  -e FLATNOTES_USERNAME=local \
  -e FLATNOTES_PASSWORD=local \
  -e FLATNOTES_SECRET_KEY=local \
  -v data:/data \
  -p 8080:8080 \
   wunschliste:dev
```