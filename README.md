# nebula-sql-backup-agent
K8s cronjob for backing up the nebula DB  


Required ENV:
```
SQL_HOST
SQL_USER
SQL_PASS
SQL_DB
GCP_GS_BUCKET
```

Required mounts:
```
/etc/gcp-sa/service-account.json
```
