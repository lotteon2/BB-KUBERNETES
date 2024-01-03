#!/bin/bash

# Array of services
services=('admin' 'auth' 'delivery' 'notification' 'order' 'payment' 'product' 'store' 'user' 'wishlist' 'giftcard')

# Iterate over each service
for ((i=0; i<${#services[@]}; i++)); do
  service=${services[i]}

  kubectl apply -f service/$service/deployment.yml
  kubectl apply -f service/$service/service.yml

  echo "Created $service/prod/service.yml"
done
