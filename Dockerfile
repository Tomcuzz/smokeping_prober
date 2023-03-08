FROM golang:1.20

WORKDIR /go/src/github.com/superq/smokeping_prober

# pre-copy/cache go.mod for pre-downloading dependencies and only redownloading them in subsequent builds if they change
COPY . .
RUN go mod download && go mod verify

RUN go build -o main *.go

EXPOSE 9374
ENTRYPOINT  [ "./main" ]