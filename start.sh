#!/bin/bash


declare -A services=(
    [1]='giftcard'
    [3]='auth'
    [4]='delivery'
    [5]='notification'
    [6]='order'
    [7]='payment'
    [8]='product'
    [9]='store'
    [10]='user'
    [12]='wishlist'
)

kubectl apply -f kube-util/util/namespace.yml
kubectl apply -f kube-util/util/mysql-config.yml
kubectl apply -f kube-util/util/redis-config.yml

kubectl apply -f kube-util/zookeeper/deployment.yml
kubectl apply -f kube-util/zookeeper/service.yml

kubectl apply -f kube-util/kafka/pv.yml
kubectl apply -f kube-util/kafka/pvc.yml
kubectl apply -f kube-util/kafka/deployment.yml
kubectl apply -f kube-util/kafka/service.yml

kubectl apply -f database/redis/pv.yml
kubectl apply -f database/redis/pvc.yml
kubectl apply -f database/redis/deployment.yml
kubectl apply -f database/redis/service.yml

kubectl apply -f database/mongodb/pv.yml
kubectl apply -f database/mongodb/pvc.yml
kubectl apply -f database/mongodb/statefulset.yml
kubectl apply -f database/mongodb/service.yml

kubectl apply -f service/discovery/deployment.yml
kubectl apply -f service/discovery/service.yml

kubectl apply -f service/config/config-local.yaml
kubectl apply -f service/config/deployment.yml
kubectl apply -f service/config/service.yml

kubectl apply -f ../apigateway/prod/deployment.yml
kubectl apply -f ../apigateway/prod/service.yml

kubectl apply -f ../orderquery/prod/deployment.yml
kubectl apply -f ../orderquery/prod/service.yml


selected_services=("${!services[@]}")

while true; do
    # Display the menu for choosing a service
    echo "Choose one service:"

    # Display the available services
    for key in "${selected_services[@]}"; do
        echo "$key) ${services[$key]}"
    done

    echo "0) Quit"

    # Prompt the user to choose a service
    read -p "> " service_choice

    case $service_choice in
        0)
            echo "Exiting the script"
            exit 0
            ;;
        [1-9]|1[0-2])
            selected_service=${services[$service_choice]}
            echo "$selected_service service running start"
            # Add your code for the selected service here

            kubectl apply -f database/$selected_service/pv.yml
            kubectl apply -f database/$selected_service/pvc.yml
            kubectl apply -f database/$selected_service/statefulset.yml
            kubectl apply -f database/$selected_service/service.yml

            kubectl apply -f service/$selected_service/initdb-config.yml
            kubectl apply -f service/$selected_service/deployment.yml
            kubectl apply -f service/$selected_service/service.yml

            # Update the available services for the next iteration
            unset "services[$service_choice]"
            selected_services=("${!services[@]}")
            ;;
        *)
            echo "Invalid selection. Please choose a valid option."
            ;;
    esac
done