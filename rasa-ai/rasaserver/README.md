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

# Chat history logger

The chat history logger requires the Rasa custom action server to be running at port 5055. After every story ends, the chats will be saved into the chats.csv excel file in the following format:

1) Intent
2) User input
3) Action
4) Bot Reply

# Form Filling

The form filling is used for taking form inputs from user and save it in file (userdata.csv)
Following inputs are taken from user:

1) Name
2) Phone Number
3) Email
4) Aadhar Number
