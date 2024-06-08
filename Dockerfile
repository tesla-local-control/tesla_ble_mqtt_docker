FROM golang:1.22-alpine3.18 as build

RUN apk add --no-cache \
  unzip

RUN mkdir -p /app/bin

# install Tesla Go packages
ADD https://github.com/teslamotors/vehicle-command/archive/refs/heads/main.zip /tmp
RUN unzip /tmp/main.zip -d /app
WORKDIR /app/vehicle-command-main
RUN go get ./...
RUN go build -o /app/bin ./...

FROM alpine:3.19.1

# install dependencies
# RUN apk add --no-cache \
#  python3 

# Create various working directories
# RUN mkdir /data /share

# Copy project files into required locations
#COPY tesla_http_proxy/app /app

# Copy tesla-http-proxy binary from build stage
# COPY --from=build /app/bin/tesla-http-proxy /app/bin/tesla-keygen /usr/bin/

# Set environment variables
# ENV GNUPGHOME="/data/gnugpg"
# ENV PASSWORD_STORE_DIR="/data/password-store"

# Python 3 HTTP Server serves the current working dir
# WORKDIR /app

# ENTRYPOINT ["/app/run.sh"]
