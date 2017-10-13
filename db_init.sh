#!/bin/sh
dbname="postgres"
username="postgres"
host="localhost"
psql -U $username -h $host << EOF

CREATE USER civis_user_db_access WITH PASSWORD 'civis_pass';
CREATE DATABASE wordcount_dev OWNER civis_user_db_access;

EOF