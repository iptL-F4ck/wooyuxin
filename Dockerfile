FROM alpine

ADD web/supervisord/mongo-connector.ini /etc/supervisor.d/
ADD web/app.tar.gz /app
WORKDIR /app

RUN sed -i 's/http:\/\/dl-cdn.alpinelinux.org/https:\/\/mirrors.tuna.tsinghua.edu.cn/g' /etc/apk/repositories \
    && apk update
RUN apk add --no-cache curl supervisor python2 python3 mongodb-tools binutils libc-dev py3-pip gcc g++ libffi-dev musl-dev \
    && apk add --no-cache --virtual .pynacl_deps build-base python3-dev
RUN pip3 install --no-cache-dir --ignore-installed pipenv -i https://pypi.tuna.tsinghua.edu.cn/simple
RUN pip3 install --no-cache-dir --ignore-installed mongo-connector elastic2-doc-manager elastic-doc-manager[elastic5] -i https://pypi.tuna.tsinghua.edu.cn/simple
RUN pipenv install
RUN apk del .pynacl_deps gcc g++ libffi-dev musl-dev \
    && rm -rf /var/cache/apk/*

EXPOSE 5000