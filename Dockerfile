# ARG ARCH="amd64"
# ARG OS="linux"
# FROM quay.io/prometheus/busybox-${OS}-${ARCH}:latest
# LABEL maintainer="Ben Kochie <superq@gmail.com>"

# ARG ARCH="amd64"
# ARG OS="linux"
# COPY .build/${OS}-${ARCH}/smokeping_prober /bin/smokeping_prober

# EXPOSE 9374
# ENTRYPOINT  [ "/bin/smokeping_prober" ]

FROM golang:1.20

WORKDIR /go/src/github.com/superq/smokeping_prober

# pre-copy/cache go.mod for pre-downloading dependencies and only redownloading them in subsequent builds if they change
COPY . .
RUN go mod download && go mod verify

RUN go build -o main *.go

EXPOSE 9374
ENTRYPOINT  [ "./main" ]