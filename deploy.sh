#!/bin/bash
docker-compose -f docker-compose.production.yml pull
docker-compose -f docker-compose.production.yml run --rm web rake db:migrate
docker-compose -f docker-compose.production.yml up -d
