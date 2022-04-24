FROM golang:1.14.9-alpine as builder
RUN mkdir /app
ADD . /app
WORKDIR /app
RUN go build -o main .

FROM alpine:3.14 as production
RUN mkdir /app
WORKDIR /app
COPY --from=builder app/main .
COPY public/ public/
EXPOSE 3000
CMD ["/app/main"]
