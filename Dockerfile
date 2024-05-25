FROM golang AS builder

WORKDIR /app

COPY go.mod .
COPY go.sum .

RUN go mod download

COPY cmd ./cmd
COPY lib ./lib
COPY templates ./templates
COPY main.go .

RUN CGO_ENABLED=0 go build -o ./fizzbuzz

FROM scratch

COPY --from=builder /app/fizzbuzz /fizzbuzz
COPY templates /templates

EXPOSE 8080

CMD ["/fizzbuzz", "serve"]