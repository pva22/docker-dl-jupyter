1. Установить докер 
```
sudo apt-get update

sudo apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg \
    lsb-release
    
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

echo \
  "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/nul
  
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io

sudo curl -L https://github.com/docker/compose/releases/download/1.21.2/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
docker-compose --version
```

3. Установить гит
```
sudo apt-get install git
```

5. Склонировать с гит докер для dl 
```
git clone <url>
```

7. https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/install-guide.html
```
curl https://get.docker.com | sh \
  && sudo systemctl --now enable docker
  
distribution=$(. /etc/os-release;echo $ID$VERSION_ID) \
   && curl -s -L https://nvidia.github.io/nvidia-docker/gpgkey | sudo apt-key add - \
   && curl -s -L https://nvidia.github.io/nvidia-docker/$distribution/nvidia-docker.list | sudo tee /etc/apt/sources.list.d/nvidia-docker.list
   
sudo apt-get update
sudo apt-get install -y nvidia-docker2
sudo systemctl restart docker

#проверка
sudo docker run --rm --gpus all nvidia/cuda:<CUDA текущая версия>-base nvidia-smi
```

5. Image из Dockerfile 
```docker build -t datascience . ```

6. Контейнер из образа с параметрами<br>
```docker container run -it --shm-size=2gb --gpus all -d -p 8888:8888 -p 6006:6006 -p 6007:6007 --name vlad-sber-dl datascience``` <br>
ИЛИ <br>
TODO: в docker-compose.yml не удалось задать параметры для запуска совместно с GPU<br>
```docker-compose up если есть валидный docker-compose.yml``` 

```docker cp <container-name>:/root/dockerLogs/install-logs.log .```<br>
```docker exec -it <container name> /bin/bash```

7. Запуск tensorboard из контейнера
```
tensorboard --logdir runs --host 0.0.0.0
```
