#!/bin/bash

# Exit immediately if a command exits with a non-zero status.
set -e

# Inject secrets into the config file
echo "CLIENT_ID = $CLIENT_ID" > Config.xcconfig
echo "CLIENT_SECRET = $CLIENT_SECRET" >> Config.xcconfig

