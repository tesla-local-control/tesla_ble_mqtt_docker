FROM golang:1.22.7-alpine3.20 AS build

RUN apk add --no-cache \
  unzip

RUN mkdir -p /app/bin

# install Tesla Go packages
ADD https://github.com/teslamotors/vehicle-command/archive/refs/tags/v0.1.0.zip /tmp
RUN unzip /tmp/vehicle-command-v0.1.0.zip -d /app
WORKDIR /app/vehicle-command-main
RUN go get ./...
RUN go build -o /app/bin ./...

FROM alpine:3.20.3

# install dependencies
RUN apk add --no-cache \
  bluez \
  bluez-deprecated \
  mosquitto-clients \
  openssl

# Create various working directories
RUN mkdir /data

# Copy project files into required locations
COPY app liblog.sh libproduct.sh /app/

# Copy binaries from build stage
COPY --from=build /app/bin/tesla-control /usr/bin/

CMD [ "/app/run.sh" ]
