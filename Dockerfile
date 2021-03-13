FROM golang:1.10-alpine3.8 AS multistage

RUN apk add --no-cache --update git

WORKDIR /go/src/ola
COPY . .

RUN go get -d -v \
  && go install -v \
  && go build

##

#FROM alpine:3.8
FROM scratch
#FROM busybox
#COPY --from=multistage /go/bin/ola /go/bin/
COPY --from=multistage /go/bin/ola /go/bin/
EXPOSE 3000
CMD ["/go/bin/ola"]