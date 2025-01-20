# Create a PostgreSQL Database in Docker

# Pull/Download Official Postgres Image From Docker Hub
```
docker pull postgres
```

# Create and Run Postgres Container
```
docker run -d --name arkon_data -p 5432:5432 -e POSTGRES_PASSWORD=pass1234 postgres
```

# execute 'postgresDB.ipynb'
