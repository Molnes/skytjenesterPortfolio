# build a golang image
FROM golang:latest

WORKDIR /

COPY go.mod ./
RUN go mod download && go mod verify

COPY . .
RUN go build -v -o main.o

EXPOSE 8080

CMD ["./main.o"]