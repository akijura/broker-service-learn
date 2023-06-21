FROM golang:1.19-alpine3.18 AS builder

WORKDIR /app
COPY . .


RUN export NO_PROXY=logger-service
RUN go build -o main ./cmd/api


# build a tiny docker image

FROM alpine:latest

WORKDIR /app
RUN export NO_PROXY=logger-service
COPY --from=builder /app/main .

CMD ["/app/main"]