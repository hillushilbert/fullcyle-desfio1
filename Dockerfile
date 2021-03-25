FROM golang:1.10-alpine3.8 AS multistage

RUN apk add --no-cache --update git

WORKDIR /go/src/ola
COPY ./src .

#RUN go get -d -v \
#  && go install -v \
#  && go build -a

RUN go get -d -v \
  && go install -v \
  && CGO_ENABLED=0 go build  -ldflags "-s -w" -o /executavel/demo


#RUN CGO_ENABLED=0 go build -o /bin/demo
##

#FROM alpine:3.8
FROM scratch
#FROM busybox
#COPY --from=multistage /go/bin/ola /go/bin/
COPY --from=multistage /executavel/demo /executavel/demo
#EXPOSE 3000
#CMD ["/go/bin/ola"]
CMD ["/executavel/demo"]