FROM golang:1.20.0-alpine3.17 as builder

COPY go.mod go.sum /go/src/github.com/boonys20/hello-app/
WORKDIR /go/src/github.com/boonys20/hello-app
RUN go mod download
COPY . /go/src/github.com/boonys20/hello-app
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o build/hello-app github.com/boonys20/hello-app


FROM alpine

RUN apk add --no-cache ca-certificates && update-ca-certificates
COPY --from=builder /go/src/github.com/boonys20/hello-app/build/hello-app /usr/bin/hello-app

EXPOSE 8080 8080

ENTRYPOINT ["/usr/bin/hello-app"]
