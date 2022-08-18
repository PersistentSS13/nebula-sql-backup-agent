FROM google/cloud-sdk:398.0.0-alpine


RUN apk --update add mysql-client

COPY . /run
RUN chmod +x /run/run_backup.sh

ENTRYPOINT ["/run/run_backup.sh"]
