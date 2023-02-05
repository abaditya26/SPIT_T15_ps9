FROM tensorflow/tensorflow
RUN mkdir -p /rasa_app
WORKDIR /rasa_app
COPY . /rasa_app
RUN pip3 install -r requirements.txt --use-feature=2020-resolver
RUN pip3 install --user rasa

