echo PUT_YOUR_TOKEN_HERE | docker login ghcr.io -u sahilrajputwins --password-stdin
docker build -t ghcr.io/sahilrajputwins/demo/demo:latest .
docker push ghcr.io/sahilrajputwins/demo/demo:latest
