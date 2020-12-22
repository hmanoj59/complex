docker build -t hmanoj59/multi-client:latest -t hmanoj59/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t hmanoj59/multi-server:latest -t hmanoj59/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t hmanoj59/multi-worker:latest -t hmanoj59/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push hmanoj59/multi-client:latest
docker push hmanoj59/multi-server:latest
docker push hmanoj59/multi-worker:latest
docker push hmanoj59/multi-client:$SHA
docker push hmanoj59/multi-server:$SHA
docker push hmanoj59/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/client-deployment client=hmanoj59/multi-client:$SHA
kubectl set image deployments/server-deployment server=hmanoj59/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=hmanoj59/multi-worker:$SHA
