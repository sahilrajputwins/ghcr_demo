docker build . -t testws
docker rm -f testwscontainer
docker run -d --name testwscontainer -p 9090:80 testws
