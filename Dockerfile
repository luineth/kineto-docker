FROM golang:1.21 AS builder

WORKDIR /app

RUN git clone https://git.sr.ht/~sircmpwn/kineto .
RUN go build -o kineto

FROM alpine:latest

RUN apk add --no-cache libc6-compat

COPY --from=builder /app/kineto /usr/local/bin/kineto

EXPOSE 8080

ENV KINETO_URL ""
ENV KINETO_BIND ":8080"
ENV KINETO_CSS_FILE ""
ENV KINETO_CSS_URL ""
ENV KINETO_DISABLE_PROXY "false"

CMD ["sh", "-c", "kineto \
    $([ \"$KINETO_DISABLE_PROXY\" = \"true\" ] && echo '-P') \
    -b $KINETO_BIND \
    $([ -n \"$KINETO_CSS_FILE\" ] && echo \"-s $KINETO_CSS_FILE\") \
    $([ -n \"$KINETO_CSS_URL\" ] && echo \"-e $KINETO_CSS_URL\") \
    $KINETO_URL"]
