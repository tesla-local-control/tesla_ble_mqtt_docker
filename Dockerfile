FROM golang:alpine3.21 AS build

RUN apk add --no-cache git unzip

RUN mkdir -p /app/bin

# Install Tesla Go packages
ENV GOPATH=/root/go
ENV VEHICLE_COMMAND_VERSION=0.3.3
WORKDIR /vehicle-command-$VEHICLE_COMMAND_VERSION
#RUN git clone https://github.com/teslamotors/vehicle-command.git /vehicle-command
#RUN git checkout releases/v0.3.3

ADD https://github.com/teslamotors/vehicle-command/archive/refs/tags/v$VEHICLE_COMMAND_VERSION.zip /tmp
RUN unzip /tmp/v$VEHICLE_COMMAND_VERSION.zip -d /

# Apply patch, see https://github.com/tesla-local-control/tesla_ble_mqtt_core/issues/125
# Thanks to https://github.com/BogdanDIA                                                         
COPY patches/vehicle-command/device_linux.go /vehicle-command-$VEHICLE_COMMAND_VERSION/pkg/connector/ble/

RUN go get ./... && \
  go build ./... && \
  go install ./...

FROM alpine:3.21.0

# install dependencies
RUN apk add --no-cache \
  bluez \
  bluez-deprecated \
  mosquitto-clients \
  openssl \
  jq

# Create various working directories
RUN mkdir /data

# Copy project files into required locations
COPY app liblog.sh libproduct.sh /app/

# Copy binaries from build stage
COPY --from=build /root/go/bin/tesla-control /usr/bin/

CMD [ "/app/run.sh" ]
