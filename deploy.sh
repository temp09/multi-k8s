docker build -t temp09/multi-client:latest -t temp09/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t temp09/multi-server:latest -t temp09/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t temp09/multi-worker:latest -t temp09/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push temp09/multi-client:latest
docker push temp09/multi-server:latest
docker push temp09/multi-worker:latest

docker push temp09/multi-client:$SHA
docker push temp09/multi-server:$SHA
docker push temp09/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=temp09/multi-server:$SHA
kubectl set image deployments/client-deployment client=temp09/client-server:$SHA
kubectl set image deployments/worker-deployment worker=temp09/worker-server:$SHA