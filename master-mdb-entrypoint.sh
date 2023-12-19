#!/bin/bash
set -e

# chmod 644 /etc/mysql/conf.d/master.cnf

# Wait for the MySQL server to be up and running
until mariadb -h localhost -u root -p"${MYSQL_ROOT_PASSWORD}" -e "SELECT 1"; do
    >&2 echo "MariaDB is unavailable - sleeping"
    sleep 1
done

# Create the replication user
mariadb -h localhost -u root -p"${MYSQL_ROOT_PASSWORD}" <<-EOSQL
    CREATE USER IF NOT EXISTS 'replicator'@'%' IDENTIFIED BY 'replication_password';
    GRANT REPLICATION SLAVE ON *.* TO 'replicator'@'%';
    FLUSH PRIVILEGES;
EOSQL

echo "Replication user created."

# Fetch the current binary log file and position
MASTER_STATUS=$(mariadb -u root -p"${MYSQL_ROOT_PASSWORD}" -e "SHOW MASTER STATUS;" | awk 'NR==2 {print $1,$2}')

# Output master status to a file
echo $MASTER_STATUS > /master-status.txt

# Execute the rest of the commands
exec "$@"

# Keep the container running
tail -f /dev/null
