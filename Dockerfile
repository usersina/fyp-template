# First stage, compile the go web server
FROM golang:1.18-alpine3.16 as builder
ENV APP_HOME /usr/src/app

RUN mkdir -p "$APP_HOME"
WORKDIR "$APP_HOME"

COPY main.go go.mod ./
RUN go build -o main .

# Second stage, run the binary
FROM alpine:3.16 as production
ENV APP_HOME /usr/src/app

RUN mkdir -p "$APP_HOME"
WORKDIR "$APP_HOME"

COPY --from=builder "$APP_HOME"/main "$APP_HOME"/go.mod ./
COPY public/ "$APP_HOME"/public

CMD [ "/usr/src/app/main" ]
