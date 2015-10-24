[![Stories in Ready](https://badge.waffle.io/brawnyelectron/vi.png?label=ready&title=Ready)](https://waffle.io/brawnyelectron/vi)
# vi

##API Interface

The API for Vi lives at [Vi API](http://viapi.io). You can interact with it using the following routes:

- `/:transcript` GET -> This is the core route for sending a transcript to the server, running (if available) a command, and returning text to be spoken back to the user. This get request should container to following:
  - transcript: passed in the url as a parameter and access in the API as req.params.transcript
  - user: passed as a json object on the req object. Using body.parser middle way to retrieve
  - WILL RETURN: A string to be passed to the "speak" function to be spoken back out by the user

##Set up

Make sure you CocoaPods installed globally. Install CocoaPods using `$ sudo gem install cocoapods`. The docs [CocoaPods setup](http://guides.cocoapods.org/using/getting-started.html)

After forking and cloning the repo run the following commands:

- `$ pod install`
- `$ ./setup` : This runs our setup executable which will download SpeechKit and place it as a framework in your Libraries directory.


Then use viapp.xcworkspace NOT viapp.xcodeproject.
