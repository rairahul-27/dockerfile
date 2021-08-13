FROM registry.access.redhat.com/ubi8/ubi-minimal:latest
WORKDIR /go/src/app
COPY . .
RUN microdnf install go
EXPOSE 3001

RUN go build -o main . 

CMD ["./main"] 
