# docker build --no-cache --pull --force-rm -t rain123473/proto-builder:g1.14-p3.12.0 -f proto-builder.dockerfile .

FROM golang:1.14

RUN apt-get update && apt-get install unzip -y
RUN wget -q -O protoc.zip https://github.com/protocolbuffers/protobuf/releases/download/v3.12.0/protoc-3.12.0-linux-x86_64.zip && unzip protoc.zip
RUN mv /go/bin/protoc /usr/local/bin/protoc && rm protoc.zip

ENV GO111MODULE=on
RUN go get github.com/golang/protobuf/protoc-gen-go
ENV PATH="$PATH:$(go env GOPATH)/bin"

WORKDIR /go/src/app