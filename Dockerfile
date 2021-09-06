FROM python:3

ADD requirements.txt /

RUN pip install -r requirements.txt

ENV WORKSPACE=/workspace
RUN mkdir -p ${WORKSPACE}
VOLUME ${WORKSPACE}
WORKDIR ${WORKSPACE}

COPY . /workspace/

CMD [ "/bin/bash"]
