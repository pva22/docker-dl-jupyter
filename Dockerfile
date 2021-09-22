FROM "ubuntu:bionic"

RUN useradd -ms /bin/bash docker
RUN su docker

ENV LOG_DIR_DOCKER="/root/dockerLogs"
ENV LOG_INSTALL_DOCKER="/root/dockerLogs/install-logs.log"

RUN mkdir -p ${LOG_DIR_DOCKER} \
 && touch ${LOG_INSTALL_DOCKER}  \
 && echo "Logs directory and file created"  | sed -e "s/^/$(date +%Y%m%d-%H%M%S) :  /" 2>&1 | tee -a ${LOG_INSTALL_DOCKER}

RUN apt-get update | sed -e "s/^/$(date +%Y%m%d-%H%M%S) :  /" 2>&1 | tee -a ${LOG_INSTALL_DOCKER} \
  && apt-get install -y python3-pip python3-dev | sed -e "s/^/$(date +%Y%m%d-%H%M%S) :  /" 2>&1 | tee -a ${LOG_INSTALL_DOCKER} \
  && ln -s /usr/bin/python3 /usr/local/bin/python | sed -e "s/^/$(date +%Y%m%d-%H%M%S) :  /" 2>&1 | tee -a ${LOG_INSTALL_DOCKER} \
  && pip3 install --upgrade pip | sed -e "s/^/$(date +%Y%m%d-%H%M%S) :  /" 2>&1 | tee -a ${LOG_INSTALL_DOCKER}

COPY requirements.txt /root/datascience/requirements.txt
WORKDIR /root/datascience
RUN pip3 install -r requirements.txt

RUN apt-get install nano
RUN apt-get -y install git
RUN apt-get install wget
RUN apt-get install zip
RUN apt-get install unzip
RUN apt-get install htop

RUN jupyter notebook --generate-config --allow-root
RUN echo "c.NotebookApp.ip = '*'" >> /root/.jupyter/jupyter_notebook_config.py
RUN echo "c.NotebookApp.open_browser = False" >> /root/.jupyter/jupyter_notebook_config.py
RUN echo "c.NotebookApp.ip = '*'" >> /root/.jupyter/jupyter_notebook_config.py
RUN echo "c.NotebookApp.open_browser = False" >> /root/.jupyter/jupyter_notebook_config.py
RUN echo "c.NotebookApp.password = 'sha1:6eaab7980733:26c77f819584243220243676f7759b9fe0cce8fd'" >> /root/.jupyter/jupyter_notebook_config.py
RUN echo "c.NotebookApp.port = 8888" >> /root/.jupyter/jupyter_notebook_config.py


CMD ["jupyter", "notebook", "--allow-root", "--notebook-dir=.", "--ip=*", "--port=8888", "--no-browser"]
