#!/bin/bash

# Wait until MySQL is ready
while ! exec 6<>/dev/tcp/mysql/3306; do
    echo "Trying to connect to MySQL at 3306..."
    sleep 5
done

echo "Mysql is ready ✅"

echo "Start DB migrations..."
rails db:migrate
echo "DB migrations has been completed ✅"

# Remove Pids file
if [ -f tmp/pids/server.pid ]; then
    rm tmp/pids/server.pid
fi

rails s -b 0.0.0.0 -p 3000
