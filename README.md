1. Установить докер 
2. Установить гит
3. Склонировать с гит докер для dl 
4. https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/install-guide.html
#image из Dockerfile
5. docker build -t datascience . 
#контейнер из образа с параметрами
6. docker container run --gpus all -d --expose 8888 -p 8888:8888 --name vlad-sber-dl datascience 
ИЛИ 
docker-compose up если есть валидный docker-compose.yml 

docker cp <container-name>:/root/dockerLogs/install-logs.log .
docker exec -it <container name> /bin/bash
