docker build -t hareram/multi-client:latest -t hareram/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t hareram/multi-server:latest -t hareram/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t hareram/multi-worker:latest -t hareram/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push hareram/multi-client:latest
docker push hareram/multi-server:latest
docker push hareram/multi-worker:latest

docker push hareram/multi-client:$SHA
docker push hareram/multi-server:$SHA
docker push hareram/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=hareram/multi-server:$SHA
kubectl set image deployments/client-deployment client=hareram/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=hareram/multi-worker:$SHA