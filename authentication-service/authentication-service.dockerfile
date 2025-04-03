FROM golang:1.24 AS builder

WORKDIR /app
COPY . .

RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o authApp ./cmd/api

# Use a minimal image to run the binary
FROM alpine:latest

WORKDIR /root/
COPY --from=builder /app/authApp .

CMD ["./authApp"]