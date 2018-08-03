FROM golang:1.10-alpine

RUN apk add --no-cache git bash
RUN git clone https://github.com/umar-muneer/azure-sdk-for-go-samples.git /go/src/github.com/Azure-Samples/azure-sdk-for-go-samples
RUN go get github.com/golang/dep/cmd/dep && \
    mkdir /app && \
    mv /go/src/github.com/Azure-Samples/azure-sdk-for-go-samples/tools/get_index /app/get_index && \
    chmod +x /app/get_index && \
    mv /go/src/github.com/Azure-Samples/azure-sdk-for-go-samples/tools/metadata.yml /app/metadata.yml && \
    go run /go/src/github.com/Azure-Samples/azure-sdk-for-go-samples/tools/list/list.go > /app/test_index

WORKDIR /go/src/github.com/Azure-Samples/azure-sdk-for-go-samples
RUN dep ensure
ENV AZURE_AUTH_LOCATION /mnt/secrets/authfile.json

WORKDIR /go/src/github.com/Azure-Samples/azure-sdk-for-go-samples