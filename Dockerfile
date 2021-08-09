FROM registry.access.redhat.com/ubi8/ubi-minimal:latest
WORKDIR /golang,  

RUN microdnf install -y \ 

curl \ 

make \ 

gcc \ 

git \ 

tar \ 

gcc-c++ 

RUN curl -fsSLo /tmp/go.tgz https://golang.org/dl/go${RUNTIME_VERSION}.linux-amd64.tar.gz; \ 

mkdir -p bin; \ 

tar -C /golang -xzf /tmp/go.tgz; \ 

rm /tmp/go.tgz; \ 

export PATH="/golang/go/bin:${PATH}"; \ 

go version 

 

 
FROM registry.access.redhat.com/ubi8/ubi-minimal:latest
WORKDIR /go/src/app
COPY . .
EXPOSE 3001

RUN go build -o main . 

CMD ["./main"] 
