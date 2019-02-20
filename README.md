# APRSme

[![Build Status](https://travis-ci.org/aprsme/aprsme.svg?branch=master)](https://travis-ci.org/aprsme/aprsme)

# Configuration

## NEW: Use RabbitMQ and aprs_slurp with docker-compose:
    $ docker-compose up

You can then view the RabbitMQ admin at http://localhost:15672/
The default bitnami username and password are in docker-compose.yml

## OLD: (rabbitMQ and aprs_slurp run locally)

    $ brew install rabbitmq

### Start RabbitMQ:

    $ brew services start rabbitmq

### Configure RabbitMQ

Create the aprs vhost:

    $ rabbitmq-plugins enable rabbitmq_management
    $ rabbitmqadmin declare vhost name=aprs

You may need to curl http://localhost:15672/cli/rabbitmqadmin and add it in /usr/local/bin, and chmod +x the file to get access to it. Recommended to add yourself to the rabbitmq group, and change the ownership over to that group.

Alternatively, open the RabbitMQ admin interface at http://localhost:15672/#/vhosts, and add a vhost named "aprs"

## Install dependencies:

    $ mix deps.get

## Start the web server:

    $ iex -S mix phx.server

## Migrate the database:

    $ mix ecto.migrate

Or on prod/staging:

    $ ssh aprs.vntx.net -t "sudo dokku run aprs_web 'mix ecto.migrate'"

## Seed the database and create an admin user:

    $ mix run priv/repo/seeds.exs


Then navigate to <a href="http://127.0.0.1:4000/">http://127.0.0.1:4000/</a> and you should see the messages coming in via websocket.

## Running tests

    $ mix test.watch

## Deploying

Add dokku as a remote:

    $ git remote add prod dokku@aprs.vntx.net:aprs_web

Push:

    $ git push prod master


## Troubleshooting message publishing

Use the script (requires jq to be installed):

    $ ./bin/inspect_rabbit

You can also retrieve RabbitMQ publish/deliver stats using cURL, the Rabbit management API, and the `jq` command.

Retrieve the number of messages published by the Perl script. If it is zero, nothing is being published at all.

    $ curl -s -u guest:guest http://localhost:15672/api/exchanges/aprs/aprs:messages | jq '.message_stats .publish_in_details .rate'

Retrieve publish & deliver rates for the aprs:archive queue:

    $ curl -s -u guest:guest http://localhost:15672/api/queues/aprs/aprs:archive | jq '.message_stats'

```json
{
  "deliver_get": 90813,
  "deliver_get_details": {
    "rate": 0
  },
  "deliver_no_ack": 90813,
  "deliver_no_ack_details": {
    "rate": 0
  },
  "publish": 92103,
  "publish_details": {
    "rate": 52
  }
}
```

  * If `publish_details.rate` drops to 0, then the Perl ingest script is either not properly running, or the exchange is wired wrong.

        $ ... | jq '.message_stats .publish_details .rate'


  * If `deliver_get_details.rate` drops to 0, then nothing is consuming messages from aprs:archive (there is a problem).

        $ ... | jq '.message_stats .deliver_get_details .rate'


## Store.js docs
  * https://github.com/marcuswestin/store.js

## Dokku config vars MUST be set
  * DATABASE_URL
  * DOKKU_LETSENCRYPT_EMAIL: graham@mcintire.me
  * HOSTNAME:                aprs.me
  * RABBITMQ_URL
  * SECRET_KEY_BASE

