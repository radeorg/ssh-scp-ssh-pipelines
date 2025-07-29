FROM python:3.11-slim-bullseye

LABEL maintainer="Lait zhang <lait.zhang@gmail.com>"
LABEL repository="https://github.com/radeorg/ssh-scp-ssh-pipelines"
LABEL version="v1.1.0"

LABEL com.github.actions.name="ssh-scp-ssh-pipelines"
LABEL com.github.actions.description="Pipeline: ssh -> scp -> ssh"
LABEL com.github.actions.icon="terminal"
LABEL com.github.actions.color="gray-dark"

RUN apt-get update -y && \
    apt-get install -y --no-install-recommends \
        ca-certificates openssh-client openssl sshpass && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

COPY requirements.txt /requirements.txt
RUN pip3 install --no-cache-dir -r /requirements.txt

RUN mkdir -p /opt/tools

COPY entrypoint.sh /opt/tools/entrypoint.sh
RUN chmod +x /opt/tools/entrypoint.sh

COPY app.py /opt/tools/app.py
RUN chmod +x /opt/tools/app.py

ENTRYPOINT ["/opt/tools/entrypoint.sh"]