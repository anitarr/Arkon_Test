# Create a PostgreSQL Database in Docker

# Pull/Download Official Postgres Image From Docker Hub
```
docker pull postgres
```

# Create and Run Postgres Container
```
docker run -d --name postgresArkon -p 5432:5432 -e POSTGRES_PASSWORD=pass123 postgres
```

