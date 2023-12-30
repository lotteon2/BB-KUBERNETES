#!/bin/bash

# Array of services
services=('apigateway' 'auth' 'delivery' 'notification' 'order' 'payment' 'product' 'store' 'user' 'wishlist' 'orderquery' 'giftcard')
port=(8000 9000 8300 8400 8900 8100 8800 8700 8600 8500 9900 9100)
# Iterate over each service
for ((i=0; i<${#services[@]}; i++)); do
  service=${services[i]}
  service_port=${port[i]}
  # Create the service folder if it doesn't exist
  mkdir -p "service/$service"


  # Create local-service.yml for each service
  cat <<EOL > "service/$service/deployment.yml"
apiVersion: apps/v1
kind: Deployment
metadata:
  name: $service-service
  namespace: prod
  labels:
    app: $service-service
spec:
  replicas: 1
  selector:
    matchLabels:
      app: $service-service
  template:
    metadata:
      name: $service-service
      labels:
        app: $service-service
    spec:
      containers:
        - name: $service-service
          image: nowgnas/bb:$service
          imagePullPolicy: Always
          ports:
            - containerPort: $service_port
          env:
            - name: USE_PROFILE
              value: "prod"
          readinessProbe:
            httpGet:
              path: /actuator/health/readiness
              port: $service_port
            initialDelaySeconds: 30
            periodSeconds: 30
            timeoutSeconds: 2
          # 애플리케이션이 정상 상태를 유지하고 있는지 지속해서 검사
          livenessProbe:
            httpGet:
              path: /actuator/health/liveness
              port: $service_port
            initialDelaySeconds: 30
            periodSeconds: 30
            timeoutSeconds: 2
      restartPolicy: Always

EOL


  echo "Created $service/prod/service.yml"
done
