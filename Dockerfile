FROM golang:1.22.4-alpine3.20 AS build

RUN apk add --no-cache \
  unzip

RUN mkdir -p /app/bin

# install Tesla Go packages
#ADD https://github.com/teslamotors/vehicle-command/archive/refs/heads/main.zip /tmp
#RUN unzip /tmp/main.zip -d /app
#WORKDIR /app/vehicle-command-main
RUN git clone https://github.com/tesla-local-control/vehicle-command-seth.git --branch ble-reliability-improvements /app/vehicle-command
WORKDIR /app/vehicle-command
RUN go get ./...
RUN go build -o /app/bin ./...

FROM alpine:3.20.0

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
