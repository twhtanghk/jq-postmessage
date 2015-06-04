# jq-postmessage
Cross browser communication derived from [jquery-postmessage](http://benalman.com/projects/jquery-postmessage-plugin/)

## Installation
```
bower install jq-postmessage
```

## Usage
```
# postMessage to parent window with token
$.postMessage access_token: "1234567"

# set http header
$.receiveMessage (event) ->
	$http.defaults.headers.common.Authorization = "Bearer #{event.data.access_token}"
```
