# BoubaApi

Useless REST API with Elixir & Plug & Cowboy

## How to Run

### Local
Run `mix do deps.get, run --no-halt` and server will start on port 8080

### Docker
Run the following commands:

```sh
DOCKER_BUILDKIT=1 docker build . -t <image name>
docker run --rm -p <port number>:8080 <image name>
```