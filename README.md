![](https://github.com/ressonancia/reverb-docker-image/blob/main/assets/reverb-cover.png?raw=true)

## Laravel Reverb

This image is a ease to use production ready reverb image.

## Running the container

With docker command:

```sh
docker run -d \
  -e REVERB_APP_ID=579546 \
  -e REVERB_APP_KEY=xswea5wathikqooztfux \
  -e REVERB_APP_SECRET=pxnhytlmcairr2epn5hj \
  -e REVERB_HOST=localhost \
  -e REVERB_PORT=8080 \
  -e REVERB_SCHEME=http \
  -e REVERB_SERVER_HOST=0.0.0.0 \
  -e REVERB_SERVER_PORT=8080 \
  -p 8080:8080 \
  ghcr.io/ressonancia/reverb:latest
```

With docker-compose

```yml
version: '3.8'

services:
  reverb_app:
    image: ghcr.io/ressonancia/reverb:latest
    stop_signal: SIGINT
    environment:
      - REVERB_APP_ID=579546
      - REVERB_APP_KEY=xswea5wathikqooztfux
      - REVERB_APP_SECRET=pxnhytlmcairr2epn5hj
      - REVERB_HOST=localhost
      - REVERB_PORT=8080
      - REVERB_SCHEME=http
      - REVERB_SERVER_HOST=0.0.0.0
      - REVERB_SERVER_PORT=8080
    ports:
      - "8080:8080"
```

**The values for key and secred use here are only examples and should not be used in your deployment.**

**Take a look at the stop_signal directive. This is important to ensure gracefull shutdown. Reverb wats for SIGINT and not SIGTERM**

## Environment Variables

| Variable            | Default Value                          | Description                                  |
|---------------------|----------------------------------------|----------------------------------------------|
| REVERB_APP_ID       | -                                 | Application ID for Reverb API                |
| REVERB_APP_KEY      | -                   | Application Key for Reverb API               |
| REVERB_APP_SECRET   | -                   | Application Secret for Reverb API            |
| REVERB_HOST         | localhost                              | Host where the Reverb API is running         |
| REVERB_PORT         | 8080                                   | Port where the Reverb API is accessible      |
| REVERB_SCHEME       | http                                   | Scheme (protocol) used by the Reverb API     |
| REVERB_SERVER_HOST  | 0.0.0.0                                | Server host binding for the application      |
| REVERB_SERVER_PORT  | 8080                                   | Server port for the application to listen on |

## Running multiple applications at the same reverb container

Reverb allows us to run multiple applications at the same server. To do this using the the container we should override the reverb configuration.

If we look at [this file](https://github.com/laravel/reverb/blob/main/config/reverb.php) there will by a `apps` array we should duplicate changing the configurations.

After changing the file override when the container 

```sh
docker run -d \
  -p 8080:8080 \
  -v ./reverb.php:/var/www/app/config/reverb.php \
  ghcr.io/ressonancia/reverb:latest
```