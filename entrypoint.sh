#!/bin/sh
set -e

PATH="/bin:/sbin:/usr/bin:/usr/sbin"

# Generate SSL self-signed certs
if [ ! -e "/etc/nginx/ssl/ttrss.crt" ]
then
  openssl req \
    -subj "/CN=${TTRSS_SELF_CERT_CN}/O=${TTRSS_SELF_CERT_ORG}/C=${TTRSS_SELF_CERT_COUNTRY}" \
    -new \
    -newkey rsa:2048 \
    -days 1825 \
    -nodes \
    -x509 \
    -keyout /etc/nginx/ssl/ttrss.key \
    -out /etc/nginx/ssl/ttrss.crt
fi

# Relay to supervisord
exec supervisord -c /supervisord.conf