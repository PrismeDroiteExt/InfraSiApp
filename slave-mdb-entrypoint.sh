#!/bin/bash
set -e

# chmod 644 /etc/mysql/conf.d/slave.cnf

# # Function to fetch master status
# fetch_master_status() {
#     # Implement logic to fetch master status from the master container
#     # For example, using Docker volumes or other synchronization mechanisms
# }

# Wait for the master status to be available
# until fetch_master_status; do
#     >&2 echo "Waiting for master status..."
#     sleep 5
# done
sleep 30

# Read master status from a known location
MASTER_LOG_FILE=$(cat /path/to/master-status.txt | cut -d' ' -f1)
MASTER_LOG_POS=$(cat /path/to/master-status.txt | cut -d' ' -f2)

# Start MariaDB in the background
mariadbd_safe &
sleep 10

# Configure replication
mariadb -u root -p"${MYSQL_SLAVE_PASSWORD}" <<-EOSQL
    CHANGE MASTER TO
        MASTER_HOST='mariadb-master',
        MASTER_USER='replicator',
        MASTER_PASSWORD='replication_password',
        MASTER_LOG_FILE='${MASTER_LOG_FILE}',
        MASTER_LOG_POS=${MASTER_LOG_POS};
    START SLAVE;
EOSQL

# Keep the container running
tail -f /dev/null
