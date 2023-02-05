# usage:
### Python 3.7

### Install Rasa:
```
pip install -U rasa
```

### Train the rasa:
```
rasa train
```

### Run rasa on shell:
```
rasa shell
```

### Start the Rasa server:
```
rasa run -m models --enable-api --cors "*" --debug
```

### Start the Rasa Action server:
```
rasa run actions --cors "*"
```

### Note: For saving chat history, both the above servers need to be running.

## Description

On top of the web app developed, we have also created, a 2 way Voice enabled conversation AI, based on natural language processing which extracts the intent from user and understand it and then give its response according. 

This AI acts as a means of a helpdesk assistant, which will provide businessman, functionality to interact with it. 

And ask basic questions regarding the licences like what documents are needed, what charges have to be paid, what is the estimated time taken to get licence accepted.
