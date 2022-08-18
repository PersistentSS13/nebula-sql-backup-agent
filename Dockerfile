FROM google/cloud-sdk:398.0.0-alpine


RUN apk --update add mysql-client

COPY . /run

ENTRYPOINT ["/run/run_backup.sh"]
