MYSQL_ROOT_PASSWORD=root
MYSQL_DATABASE=isidb
MYSQL_USER=user
MYSQL_PASSWORD=pass
HOSTNAME=kilo-newarch

###> symfony/framework-bundle ###
APP_ENV=dev
APP_SECRET=5e8fd4af7e15c609d4662f1b4a641fb7
###< symfony/framework-bundle ###

###> symfony/webapp-pack ###
#MESSENGER_TRANSPORT_DSN=doctrine://default?auto_setup=0
###< symfony/webapp-pack ###

###> doctrine/doctrine-bundle ###
# Format described at https://www.doctrine-project.org/projects/doctrine-dbal/en/latest/reference/configuration.html#connecting-using-a-url
# IMPORTANT: You MUST configure your server version, either here or in config/packages/doctrine.yaml
#
# DATABASE_URL="sqlite:///%kernel.project_dir%/var/data.db"
# DATABASE_URL="mysql://app:!ChangeMe!@127.0.0.1:3306/app?serverVersion=8&charset=utf8mb4"

DATABASE_URL=mysql://root:${MYSQL_ROOT_PASSWORD}@database/${MYSQL_DATABASE}?serverVersion=MariaDB-10.11.4

###< doctrine/doctrine-bundle ###

###> symfony/messenger ###
# Choose one of the transports below
# MESSENGER_TRANSPORT_DSN=doctrine://default
# MESSENGER_TRANSPORT_DSN=amqp://guest:guest@localhost:5672/%2f/messages
# MESSENGER_TRANSPORT_DSN=redis://localhost:6379/messages
###< symfony/messenger ###

###> symfony/mailer ###
#MAILER_DSN=smtp://smtp.corp.ponet:25?verify_peer=0
###< symfony/mailer ###