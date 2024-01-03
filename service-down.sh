#!/bin/bash

# Array of services
services=('admin' 'auth' 'delivery' 'notification' 'order' 'payment' 'product' 'store' 'user' 'wishlist' 'giftcard')

# Iterate over each service
for ((i=0; i<${#services[@]}; i++)); do
  service=${services[i]}

  kubectl delete service $service-service
  kubectl delete deployment $service-service

  echo "Created $service/prod/service.yml"
done
