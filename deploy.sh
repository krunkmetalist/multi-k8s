docker build -f theautonater801/multi-client:latest -t theautonater801/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -f theautonater801/multi-server:latest -t theautonater801/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -f theautonater801/multi-worker:latest -t theautonater801/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push theautonater801/multi-client:latest
docker push theautonater801/multi-server:latest
docker push theautonater801/multi-worker:latest

docker push theautonater801/multi-client:$SHA
docker push theautonater801/multi-server:$SHA
docker push theautonater801/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=theautonater801/multi-server:$SHA
kubectl set image deployments/client-deployment client=theautonater801/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=theautonater801/multi-worker:$SHA