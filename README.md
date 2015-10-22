[![Stories in Ready](https://badge.waffle.io/brawnyelectron/vi.png?label=ready&title=Ready)](https://waffle.io/brawnyelectron/vi)
# vi

##API Interface

The API for Vi lives at [Vi API](http://viapi.io). You can interact with it using the following routes:

* '/viauth' - This is used for authentication of master app calls. The authentication token for this will be used on every application. This ensures api requests are coming from installed applications or from a dev environment standpoint. Production application API keys will be hidden in the environment variables. For access to test environment, using test credentials given out to developers.

These must be passed in as parameters to calls to the '/viauth' API. It is best to do this call on applicationDidFinishLoading in Objective-C or viewDidMount in React Native. This will then give you a session to indicate all api calls from the current application environment are authenticated.

##Set up

Make sure you have Node, NPM, and CocoaPods installed globally. Install CocoaPods using `$ sudo gem install cocoapods`. The docs [CocoaPods setup](http://guides.cocoapods.org/using/getting-started.html)

After forking and cloning the repo run the following commands:

- In the ios directory run: `$ pod install`

Also add frameworks by going to the Vi targets Build Phases and adding the following linked binaries. Do this by clicking the '+' and searching by name.

You need to manually install the following frameworks:
- CFNetwork.framework
- AudioToolbox.framework
- AVFoundation.framework
- Quartzcore.framework
- CoreAudio.framework
- Security.framework
- Foundation.framework
- libicucore.dylib

You also need to add the watsonsdk.framework. Until it's on CocoaPods you need to manually download the framework. Do this be going to the [Watson Speech iOS Repo](https://github.com/watson-developer-cloud/speech-ios-sdk), cloning, and unzipping the framework. Add that to your libraries as well.

Then use viapp.xcworkspace NOT viapp.xcodeproject.
