# docker build --no-cache --pull --force-rm -t rain/proto-builder:g1.14-p3.12.0 -f proto-builder.dockerfile .
# docker run -v $(pwd):/go/src/app -w /go/src/app rain/proto-builder:g1.14-p3.12.0 sh -c 'protoc *.proto --go_out=. --micro_out=.;'

FROM golang:1.14

RUN apt-get update && apt-get install unzip -y
RUN wget -q -O protoc.zip https://github.com/protocolbuffers/protobuf/releases/download/v3.12.0/protoc-3.12.0-linux-x86_64.zip && unzip protoc.zip
RUN mv /go/bin/protoc /usr/local/bin/protoc && rm protoc.zip

ENV GO111MODULE=on
RUN go get github.com/micro/go-web
RUN go get github.com/micro/go-micro
RUN go get github.com/micro/protobuf/proto
RUN go get github.com/micro/protobuf/protoc-gen-go
RUN go get github.com/micro/protoc-gen-micro

ENV PATH="$PATH:$(go env GOPATH)/bin"

WORKDIR /go/src/app
