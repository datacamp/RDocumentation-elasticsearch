FROM alpine:3.22 AS aws-env-downloader

RUN apk add --no-cache ca-certificates curl

RUN curl --fail --show-error --location \
    https://github.com/datacamp/aws-env/releases/download/v0.1-session-fix/aws-env-linux-amd64 \
    --output /aws-env

FROM logstash:2.3

# The legacy Logstash image has an obsolete CA bundle. Copy a current bundle
# from the modern downloader stage before using aws-env at ECS runtime.
COPY --from=aws-env-downloader /etc/ssl/certs/ca-certificates.crt \
    /etc/ssl/certs/ca-certificates.crt
COPY --from=aws-env-downloader /aws-env /bin/aws-env

RUN chmod +x /bin/aws-env

RUN rm -f /usr/share/logstash/pipeline/logstash.conf

ADD pipeline/ /usr/share/logstash/pipeline/
ADD config/ /usr/share/logstash/config/
ADD jdbc /usr/share/logstash/jdbc/
