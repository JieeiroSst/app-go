FROM golang:latest
LABEL maintainer="Alain Luu <luumanhquan.91@gmail.com>"
RUN mkdir /app
WORKDIR /app
COPY go.mod /app
COPY go.sum /app
COPY . .
RUN go mod download 
ADD . /app/
WORKDIR /app
RUN go build -o main .
EXPOSE 9000
CMD ["/app/main"]