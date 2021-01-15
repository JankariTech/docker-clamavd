FROM alpine:3.13.0

RUN apk add --update bash clamav clamav-libunrar && \
    rm -fr /var/cache/apk/*

RUN mkdir /run/clamav && \
    chown clamav:clamav /run/clamav && \
    chmod 750 /run/clamav && \
    freshclam && \
    echo "Foreground true" >> /etc/clamav/clamd.conf && \
    echo "TCPSocket 3310" >> /etc/clamav/clamd.conf && \
    echo "Foreground true" >> /etc/clamav/freshclam.conf

EXPOSE 3310

ADD run.sh /

CMD ["/run.sh"]
