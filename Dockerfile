FROM golang:1.22 AS builder

WORKDIR /app
COPY . .

RUN CGO_ENABLED=0 GOOS=linux go build -o fizzbuzz

FROM gcr.io/distroless/base-debian12

WORKDIR /app

COPY --from=builder /app/fizzbuzz .
COPY --from=builder /app/templates ./templates

CMD ["./fizzbuzz", "serve"]