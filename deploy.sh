docker build -t alvarogonzavega/multi-client:latest -t alvarogonzavega/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t alvarogonzavega/multi-server:latest -t alvarogonzavega/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t alvarogonzavega/multi-worker:latest -t alvarogonzavega/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push alvarogonzavega/multi-client:latest
docker push alvarogonzavega/multi-server:latest
docker push alvarogonzavega/multi-worker:latest
docker push alvarogonzavega/multi-client:$SHA
docker push alvarogonzavega/multi-server:$SHA
docker push alvarogonzavega/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=alvarogonzavega/multi-server:$SHA
kubectl set image deployments/client-deployment client=alvarogonzavega/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=alvarogonzavega/multi-worker:$SHA
