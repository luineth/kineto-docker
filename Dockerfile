FROM golang:1.21 AS builder

WORKDIR /app/kineto
COPY upstream/. .
ARG TARGETARCH

RUN CGO_ENABLED=0 GOOS=linux GOARCH=$TARGETARCH go build -o /app/kineto

FROM alpine:latest
RUN apk add --no-cache libc6-compat
COPY --from=builder /app/kineto /app/kineto
EXPOSE 8080

ENV KINETO_URL=""
ENV KINETO_CSS_FILE=""
ENV KINETO_CSS_URL=""
ENV KINETO_DISABLE_PROXY="false"

CMD ["sh", "-c", "/app/kineto \
    $([ \"$KINETO_DISABLE_PROXY\" = \"true\" ] && echo '-P') \
    $([ -n \"$KINETO_CSS_FILE\" ] && echo \"-s $KINETO_CSS_FILE\") \
    $([ -n \"$KINETO_CSS_URL\" ] && echo \"-e $KINETO_CSS_URL\") \
    $KINETO_URL"]
