FROM registry.access.redhat.com/ubi8/ubi-minimal:latest AS builder

RUN mkdir /golang
WORKDIR /golang

RUN microdnf install -y \ 
curl \
make \ 
gcc \ 
git \ 
tar \ 
gcc-c++ 

RUN curl -fsSLo /tmp/go.tgz https://golang.org/dl/go1.16.6.linux-amd64.tar.gz; \ 
mkdir -p bin; \ 
tar -C /golang -xzf /tmp/go.tgz; \ 
rm /tmp/go.tgz; \ 
export PATH="/golang/go/bin:${PATH}"; \ 
go version 

FROM registry.access.redhat.com/ubi8/ubi-minimal:latest
RUN mkdir /go/src/app
WORKDIR /go/src/app
COPY --from=builder /golang/go /usr/local
ENV GOPATH=/go
COPY . .
EXPOSE 3001

CMD ["go","run","main.go"] 
