FROM golang:alpine3.21 AS build

RUN apk add --no-cache git

RUN mkdir -p /app/bin

# install Tesla Go packages
RUN git clone https://github.com/teslamotors/vehicle-command.git /vehicle-command
WORKDIR /vehicle-command
ENV GOPATH=/root/go
RUN git checkout tags/v0.2.1
RUN go get ./... && \
  go build ./... && \
  go install ./...

FROM alpine:3.21.0

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
COPY --from=build /root/go/bin/tesla-control /usr/bin/
COPY --from=build /root/go/ /root
COPY --from=build /vehicle-command /root

CMD [ "/app/run.sh" ]
