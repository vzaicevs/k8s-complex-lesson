docker build -t vzaicevs/multi-client:latest -t vzaicevs/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t vzaicevs/multi-server:latest -t vzaicevs/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t vzaicevs/multi-worker:latest -f vzaicevs/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push vzaicevs/multi-client:latest
docker push vzaicevs/multi-server:latest
docker push vzaicevs/multi-worker:latest

docker push vzaicevs/multi-client:$SHA
docker push vzaicevs/multi-server:$SHA
docker push vzaicevs/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=vzaicevs/multi-server:$SHA
kubectl set image deployments/client-deployment client=vzaicevs/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=vzaicevs/multi-worker:$SHA
