#!/usr/bin/env bash
# Fetch production dependencies
mix deps.get --only prod

# Compile the app
mix compile

# Build static assets
cd assets
npm install
npm run deploy
cd ..

# Generate digested assets
mix phx.digest
