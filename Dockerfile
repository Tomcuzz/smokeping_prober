FROM golang:1.20

WORKDIR /go/src/github.com/superq/smokeping_prober

# pre-copy/cache go.mod for pre-downloading dependencies and only redownloading them in subsequent builds if they change
COPY . .

# Get dependancies
RUN go mod download && go mod verify

# Build the Go app
RUN go build -o main *.go

# Expose port 8086 to the outside world
EXPOSE 9374

# Create health check to check /healthz url
HEALTHCHECK --interval=5m --timeout=3s --start-period=10s --retries=3 CMD curl -f http://localhost:9374/ || exit 1

# Command to run the executable
ENTRYPOINT  [ "./main" ]