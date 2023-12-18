#!/bin/sh


# Set the permissions
chmod 777 . -R;
cp .env app/
cd /app
# Install the app dependencies 
composer install;
composer update -W;
yarn install;
yarn upgrade -W;
composer clear-cache;

# Clear the cache
php app/bin/console cache:clear --no-warmup --env=dev;

# Warm up the cache
php app/bin/console cache:warmup --env=dev;

# Remove old migrations folder and files
rm -rf app/migrations;

# Create the migrations directory
mkdir -p app/migrations;

# Create the database and run the migrations
php app/bin/console make:migration;
php app/bin/console doctrine:migrations:migrate;

# Build the assets and start the server
exec apache2-foreground &
yarn watch

