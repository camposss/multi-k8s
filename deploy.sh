docker build -t camposss/multi-client:latest -t camposss/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t camposss/multi-server:latest -t camposss/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t camposss/multi-worker:latest -t camposss/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push camposss/multi-client:latest
docker push camposss/multi-server:latest
docker push camposss/multi-worker:latest

docker push camposss/multi-client:$SHA
docker push camposss/multi-server:$SHA
docker push camposss/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/client-deployment client=camposss/multi-client:$SHA
kubectl set image deployments/server-deployment server=camposss/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=camposss/multi-worker:$SHA