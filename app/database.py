import psycopg2
from psycopg2 import pool

DATABASE_CONFIG = {
    "database": "utkrusht_db",
    "user": "utkrusht",
    "password": "skills123",
    "host": "postgres",
    "port": "5432",
}

pg_pool = None

def init_db_pool():
    global pg_pool
    if not pg_pool:
        pg_pool = psycopg2.pool.SimpleConnectionPool(
            1, 5, **DATABASE_CONFIG
        )

def get_db_conn():
    global pg_pool
    if not pg_pool:
        init_db_pool()
    return pg_pool.getconn()

def release_db_conn(conn):
    global pg_pool
    if pg_pool and conn:
        pg_pool.putconn(conn)
