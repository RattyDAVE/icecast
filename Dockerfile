FROM alpine:edge

RUN addgroup -S icecast && \
    adduser -S icecast
    
RUN apk add --update \
        icecast \
        mailcap && \
    rm -rf /var/cache/apk/*

RUN mkdir -p /var/log/icecast && chown -R icecast:icecast /usr/share/icecast && chown -R icecast:icecast /var/log/icecast
RUN chmod 775 /etc
RUN chown -R icecast:icecast /etc/icecast.xml

COPY docker-entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

#USER icecast:root

EXPOSE 8000

#VOLUME ["/var/log/icecast"]

ENTRYPOINT ["/entrypoint.sh"]
CMD icecast -c /etc/icecast.xml
