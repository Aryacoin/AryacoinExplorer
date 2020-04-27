FROM node:12

WORKDIR /explorer

RUN apt update && apt install -y cron

COPY entrypoint.sh /
COPY crontab /crontab

RUN cat /crontab | crontab -

CMD ["/bin/sh", "-c", "/entrypoint.sh"]
