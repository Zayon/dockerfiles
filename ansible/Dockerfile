FROM python:3.11-alpine3.18

RUN pip install ansible passlib && \
    apk add --no-cache tini bash openssh-client

# Make sure the .ssh dir exists
RUN mkdir /root/.ssh && chmod 700 /root/.ssh

ENV ANSIBLE_HOME=/tmp

WORKDIR /app

COPY docker-entrypoint.sh /docker-entrypoint.sh

ENTRYPOINT ["/sbin/tini", "--", "/docker-entrypoint.sh"]

