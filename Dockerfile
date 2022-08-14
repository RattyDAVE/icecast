FROM alpine:edge

USER root
WORKDIR /root

EXPOSE 8000

COPY docker-entrypoint.sh /entrypoint.sh

RUN addgroup -S icecast && \
    adduser -S icecast && \
    apk add --update \
        icecast && \
    rm -rf /var/cache/apk/* && \
    mkdir -p /var/log/icecast && \
    chown -R icecast:icecast /usr/share/icecast && \
    chown -R icecast:icecast /var/log/icecast && \
    chmod +x /entrypoint.sh

#VOLUME ["/var/log/icecast"]

ENTRYPOINT ["/entrypoint.sh"]
CMD icecast -c /etc/icecast.xml
