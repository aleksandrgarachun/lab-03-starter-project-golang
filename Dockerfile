# Етап побудови
FROM golang:latest AS builder

WORKDIR /app

COPY go.mod . 
COPY go.sum .

RUN go mod download

COPY . .

RUN CGO_ENABLED=0 go build -o fizzbuzz

# Етап розгортання
FROM gcr.io/distroless/static-debian11

COPY --from=builder /app/fizzbuzz /fizzbuzz
COPY templates /templates

CMD ["/fizzbuzz"]
