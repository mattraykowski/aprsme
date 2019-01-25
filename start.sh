#!/bin/bash

# Wait for postgres
# This is necessary because postgres will become available, then restart itself
sleep 10

# Run migrations
mix ecto.migrate

# Run the server
mix phx.server
