kubectl apply -f kube-util/util/mysql-config.yml
kubectl apply -f kube-util/util/namespace.yml

kubectl apply -f database/product/service.yml
kubectl apply -f database/product/statefulset.yml
