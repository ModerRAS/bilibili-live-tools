FROM python:3.6-alpine

MAINTAINER zsnmwy <szlszl35622@gmail.com>

ENV LIBRARY_PATH=/lib:/usr/lib \
    USER_NAME='' \
    USER_PASSWORD=''

WORKDIR /app

COPY * /app/

RUN apk add --no-cache --virtual bili build-base python-dev py-pip jpeg-dev zlib-dev && \
    pip install --no-cache-dir -r requirements.txt && \
    rm -r /var/cache/apk && \
    rm -r /usr/share/man && \
    apk del bili

ENTRYPOINT  sed -i ''"$(cat conf/bilibili.conf -n | grep "username =" | awk '{print $1}')"'c '"$(echo "username = ${USER_NAME}")"'' conf/bilibili.conf && \
            sed -i ''"$(cat conf/bilibili.conf -n | grep "password =" | awk '{print $1}')"'c '"$(echo "password = ${USER_PASSWORD}")"'' conf/bilibili.conf && \
            python ./run.py
