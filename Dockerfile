FROM ppodgorsek/robot-framework:latest

MAINTAINER Adey Xu <aite.xat@antfin.com>
LABEL description Robot Framework and Oracle instant Client in Docker.

ENV LANG C.UTF-8

USER 0
WORKDIR /

# Set the working directory environment variable
ENV ROBOT_WORK_DIR /opt/robotframework/temp

# Define the default user who'll run the tests
ENV ROBOT_UID 1000
ENV ROBOT_GID 1000

COPY requirements.txt .

RUN apk update \
  && apk --no-cache upgrade \
  && apk --no-cache --virtual .build-deps add \
    gcc \
    libffi-dev \
    linux-headers \
    make \
    musl-dev \
  && pip3 install \
  --no-cache-dir -r requirements.txt

RUN mkdir -p /data/logs/app && apk add --no-cache ttf-freefont fontconfig

COPY msyh.ttf /usr/share/fonts/TTF/

ENV LD_LIBRARY_PATH=/lib

RUN wget https://download.oracle.com/otn_software/linux/instantclient/193000/instantclient-basic-linux.x64-19.3.0.0.0dbru.zip && \
    unzip instantclient-basic-linux.x64-19.3.0.0.0dbru.zip && \
    cp -r instantclient_19_3/* /lib && \
    rm -rf instantclient-basic-linux.x64-19.3.0.0.0dbru.zip && \
    apk add libaio

ADD script.sh /root/script.sh

RUN /root/script.sh

COPY unic.py /usr/local/lib/python3.8/site-packages/robot/utils/unic.py

USER ${ROBOT_UID}:${ROBOT_GID}

# A dedicated work folder to allow for the creation of temporary files
WORKDIR ${ROBOT_WORK_DIR}
