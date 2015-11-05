import UIKit
import QuartzCore
import Alamofire
import AudioToolbox

class HomeViewController: UIViewController, SpeechKitDelegate, SKRecognizerDelegate {
  
  var voiceSearch: SKRecognizer?
  var tts = TextToSpeech()
  var isListening: Bool = false
  let userId = UIDevice.currentDevice().identifierForVendor!.UUIDString
  var apps = [String]()
  var lang = "eng-USA" // Default to prevent crash
  let appManager = AppManager()
  var button: HamburgerButton! = nil
  
  @IBOutlet var transcript: UILabel!
  @IBOutlet var recordButton: RecordButton!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
    self.navigationController?.navigationBar.shadowImage = UIImage()
    self.navigationController?.navigationBar.translucent = true
    self.navigationController?.view.backgroundColor = UIColor.clearColor()
    
    if revealViewController() != nil {
      revealViewController().rearViewRevealWidth = 100
      
      self.button = HamburgerButton(frame: CGRectMake(0, 0, 20, 20))
      
      self.button.addTarget(revealViewController(), action: "revealToggle:", forControlEvents: .TouchUpInside)
      self.button.addTarget(self, action: "toggle:", forControlEvents: .TouchUpInside)
      
      self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: button)
      
      view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
    }
    
    let langMan = LanguageManager()
    let langres = langMan.getCurrentLang()
    self.lang = langres[1]
    
    transcript.numberOfLines = 0
    transcript.sizeToFit()
    
    /* Add Button functionality */
    createMicButtonPressFunctionality()
    
    /* Configure SpeechKit Server */
    configureNuance()
    
  }
  
  func toggle(sender: AnyObject!) {
    self.button.showsMenu = !self.button.showsMenu
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  func startListening() {
    /* There are alternate options for these:
    
      detectionType(s):
      - SKLongEndOfSpeechDetection (long utterances)
      
      recoType(s):
      - SKShortEndOfSpeechDetection - good for search look up and short small pause utterances
      - SKTvRecognizerType - good for pauses occasionally and for messages/dictation
      - SKDictationRecognizerType - Long utterances for dictation
      
      landType(s):
      - "fr_FR"
      - "de_DE"
    
    */
    if !self.isListening {
     self.voiceSearch = SKRecognizer(type: SKSearchRecognizerType, detection: UInt(SKShortEndOfSpeechDetection), language:self.lang, delegate: self)
      self.isListening = true
    } else {
      self.voiceSearch?.cancel()
      self.isListening = false
    }
  }
  
  func createMicButtonPressFunctionality() {
    self.recordButton.addTarget(self, action: "startListening", forControlEvents: .TouchUpInside)
  }
  
  /* Server & API */
  func attemptToExecuteOnTranscript(transcript: String, successCB: String -> (), failureCB: () -> ()) {

    /* Seperates words by space */
    let transcriptAsArray = transcript.componentsSeparatedByString(" ")
    let extensionName = appManager.scan(transcriptAsArray)
    print(extensionName)
    
    if extensionName == nil {
      self.tts.speak("Sorry, couldn't find plug-in. Please add relevant plug-in at the plug-in page")
    } else {
      let token = appManager.getToken(extensionName!)!
      
      /* Do call to core data to get token with the extensionName and assign to authDict. */
      let authDict = ["token": token]
      
      /* Configure final object to be sent to server as JSON */
      let parameters = ["transcript": transcript, "auth": authDict]
      
      Alamofire.request(.POST, "http://localhost:3000/command", parameters: parameters as? [String : AnyObject], encoding: .JSON)
        .responseJSON { response in
          switch response.result {
          case .Success:
            if let JSON = response.result.value {
              if let feedback = JSON["feedback"] {
                successCB(feedback as! String)
              }
              else {
                failureCB()
              }
            }
            else {
              failureCB()
            }
            
          case .Failure:
            failureCB()
          }
      }
    }
  }

  /*** Nuance ***/
  func configureNuance() {
    
    SpeechKit.setupWithID("NMDPTRIAL_garrettmaring_gmail_com20151023221408", host: "sslsandbox.nmdp.nuancemobility.net", port: 443, useSSL: true, delegate: self)
    
    let earconStart = SKEarcon.earconWithName("start_listening.wav") as! SKEarcon
    let earconStop = SKEarcon.earconWithName("start_listening.wav") as! SKEarcon
    let earconCancel = SKEarcon.earconWithName("start_listening.wav") as! SKEarcon
    SpeechKit.setEarcon(earconStart, forType: UInt(SKStartRecordingEarconType))
    SpeechKit.setEarcon(earconStop, forType: UInt(SKStopRecordingEarconType))
    SpeechKit.setEarcon(earconCancel, forType: UInt(SKCancelRecordingEarconType))
  }

  func recognizerDidBeginRecording(recognizer: SKRecognizer!) {
    NSLog("I have started recording")
  }
  
  func recognizerDidFinishRecording(recognizer: SKRecognizer!) {
    NSLog("I have finished recording")
    voiceSearch!.stopRecording()
    /* Ends animation on end of listening */
    self.recordButton.animating = !self.recordButton.animating
  }
  
  func recognizer(recognizer: SKRecognizer!, didFinishWithResults results: SKRecognition!) {
    NSLog("Some results! \n %@", results.results)
    let res = results.firstResult()
    if res == nil {
      self.tts.speak("I can't hear you")
    } else {
      transcript.text! = "\"" + res + "\""
      attemptToExecuteOnTranscript(res,
        successCB: {
          (response:String) in
//          let resDict = response as! Dictionary<String, AnyObject>
//          let feedback = (resDict["feedback"] as AnyObject?) as? String
          self.tts.speak(response)
        },
        failureCB: {
          self.tts.speak("Please check your internet connection")
        })
    }
  }
  
  func recognizer(recognizer: SKRecognizer!, didFinishWithError error: NSError!, suggestion: String!) {
    NSLog("I errored out with the following error: %@", error)
  }
  
  func audioSessionReleased() {
    self.isListening = false
    NSLog("Audio session released")
  }

  func handlePowerMeter() {
    /* Get power level */
  }
  
}
