#!/bin/bash
set -e
cd /root/task
echo "Starting PostgreSQL and FastAPI containers..."
docker-compose up -d
# Wait for PostgreSQL to be up (retry until psql connection works)
RETRIES=20
until docker exec $(docker-compose ps -q postgres) pg_isready -U utkrusht -d utkrusht_db
  do
    echo "Waiting for PostgreSQL to be healthy..."
    sleep 2
    RETRIES=$((RETRIES-1))
    if [ $RETRIES -eq 0 ]; then
        echo "PostgreSQL failed to start."
        docker-compose logs postgres
        exit 1
    fi
done
# Wait for FastAPI to be up
RETRIES=20
until curl -s http://localhost:8000/docs > /dev/null
  do
    echo "Waiting for FastAPI app to be ready..."
    sleep 2
    RETRIES=$((RETRIES-1))
    if [ $RETRIES -eq 0 ]; then
        echo "FastAPI app failed to start."
        docker-compose logs fastapi
        exit 2
    fi
done
echo "Deployment successful. FastAPI is live and connected to postgres!"
docker-compose ps
