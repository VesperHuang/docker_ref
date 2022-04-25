# docker build --no-cache --pull --force-rm -t rain/proto-builder:g1.18-p3.19.4 -f proto-builder.dockerfile .
# docker run -v $(pwd):/go/src/app -w /go/src/app rain/proto-builder:g1.18-p3.19.4 sh -c 'protoc *.proto --go_out=. --micro_out=.;'

FROM golang:1.18

RUN apt-get update && apt-get install unzip -y
RUN wget -q -O protoc.zip https://github.com/protocolbuffers/protobuf/releases/download/v3.19.4/protoc-3.19.4-linux-x86_64.zip && unzip protoc.zip
RUN mv /go/bin/protoc /usr/local/bin/protoc && rm protoc.zip

ENV GO111MODULE=on
#RUN go install github.com/micro/go-web@latest
#RUN go install github.com/micro/go-micro@latest
#RUN go install github.com/micro/protobuf/proto@3.19.4
#RUN go get github.com/micro/protobuf/protoc-gen-go
#RUN go get github.com/micro/protoc-gen-micro

RUN go install google.golang.org/protobuf/cmd/protoc-gen-go@latest
RUN go install go-micro.dev/v4/cmd/protoc-gen-micro@v4

ENV PATH="$PATH:$(go env GOPATH)/bin"

WORKDIR /go/src/app
