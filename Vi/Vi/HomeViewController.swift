import UIKit
import QuartzCore
import AFNetworking
import Alamofire
import AudioToolbox

class HomeViewController: UIViewController, SpeechKitDelegate, SKRecognizerDelegate {
  
  var voiceSearch: SKRecognizer?
  var tts = TextToSpeech()
  var animation: Bool = false
  var isListening: Bool = false
  let apiCallManager = AFHTTPRequestOperationManager()
  let userId = UIDevice.currentDevice().identifierForVendor!.UUIDString
  var apps = [String]()
  
  @IBOutlet var transcript: UILabel!
  @IBOutlet var MicButton: UIButton!
  @IBOutlet weak var rippleView: UIView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    transcript.numberOfLines = 0
    transcript.sizeToFit()
    
    /* Style Button */
    styleMicButton()
    setupViewsForRippleEffect()
    
    /* Add Button functionality */
    createMicButtonPressFunctionality()
    
    /* Configure SpeechKit Server */
    configureNuance()
    
    /* Add gesture capabilities */
    //addUpSwipeGesture()
    
    /* Configure User Data */
    configureUser()
  }
  
  func setupViewsForRippleEffect(){
    self.rippleView.layer.zPosition = 1111
    self.rippleView.layer.cornerRadius = self.rippleView.frame.size.width / 2;
    self.rippleView.clipsToBounds = true
    self.rippleView.layer.borderColor = UIColor(red: 3/255.0, green: 169/255.0, blue: 244/255.0, alpha: 1.0).CGColor
    self.rippleView.layer.borderWidth = 1
    self.rippleView.hidden = true
  }
  
  func animateRippleEffect(){
    if (!animation) {
      return ()
    }
    self.rippleView.transform = CGAffineTransformMakeScale(0.2, 0.2)
    
    UIView.animateWithDuration(0.8, delay: 0,
      options: UIViewAnimationOptions.CurveLinear,
      animations: {
        self.rippleView.transform = CGAffineTransformMakeScale(1.0, 1.0)
      }, completion: { finished in
        self.animateRippleEffect()
    })
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
     self.voiceSearch = SKRecognizer(type: SKSearchRecognizerType, detection: UInt(SKShortEndOfSpeechDetection), language:"eng-USA", delegate: self)
      self.isListening = true
    } else {
      self.voiceSearch?.cancel()
      self.isListening = false
    }
  }
  
  /* UI Set up */
  func addUpSwipeGesture() {
    let upSwipe = UISwipeGestureRecognizer(target: self, action: Selector("handleSwipes:"))
    upSwipe.direction = .Up
    view.addGestureRecognizer(upSwipe)
  }
  
  func handleSwipes(sender:UISwipeGestureRecognizer) {
    if (sender.direction == .Up) {
      NSLog("Swipe Up")
      startListening()
    }
  }
  
  func styleMicButton() {
    let circlePath = UIBezierPath.init(arcCenter: CGPointMake(MicButton.bounds.size.width / 2, MicButton.bounds.size.height / 2), radius: MicButton.bounds.size.height / 2, startAngle: 0.0, endAngle: 2 * CGFloat(M_PI), clockwise: true)
    let circleShape = CAShapeLayer()
    circleShape.path = circlePath.CGPath
    MicButton.layer.mask = circleShape
    MicButton.titleLabel?.font = UIFont.fontAwesomeOfSize(50)
    MicButton.setTitle(String.fontAwesomeIconWithCode("fa-microphone"), forState: .Normal)
  }
  
  func createMicButtonPressFunctionality() {
    self.MicButton.addTarget(self, action: "startListening", forControlEvents: .TouchUpInside)
  }
  
  /* Server & API */
  func attemptToExecuteOnTranscript(transcript: String, successCB: AnyObject -> (), failureCB: () -> ()) {
    /* Send transript with user data */
    let data = ["transcript": transcript]
    
    apiCallManager.requestSerializer = AFJSONRequestSerializer()
    apiCallManager.responseSerializer = AFJSONResponseSerializer()
    
    apiCallManager.POST(
      "http://viapi.io/command",
      parameters: data,
      success: { (operation: AFHTTPRequestOperation!,
        responseObject: AnyObject!) in
        NSLog("JSON: %@", responseObject.description)
        successCB(responseObject)
      },
      failure: { (operation: AFHTTPRequestOperation!,
        error: NSError!) in
        NSLog("Error: %@", error.localizedDescription)
        failureCB()
      }
    )
  }
  
  func configureUser() {
    var userData = [String:String]()
    userData = ["userId": userId, "extensions": apps.joinWithSeparator(", ")]
    
    apiCallManager.requestSerializer = AFJSONRequestSerializer()
    apiCallManager.responseSerializer = AFHTTPResponseSerializer()
    
    apiCallManager.POST(
      "http://viapi.io/user",
      parameters: userData,
      success: { (operation: AFHTTPRequestOperation!,
        responseObject: AnyObject!) in
        NSLog("JSON: %@", responseObject.description)
      },
      failure: { (operation: AFHTTPRequestOperation!,
        error: NSError!) in
        NSLog("Error: %@", error.localizedDescription)
      }
    )
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
    animation = true
    self.rippleView.hidden = false
    animateRippleEffect()
  }
  
  func recognizerDidFinishRecording(recognizer: SKRecognizer!) {
    NSLog("I have finished recording")
    voiceSearch!.stopRecording()
    animation = false
    self.rippleView.hidden = true
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
          (response:AnyObject) in
          let resDict = response as! Dictionary<String, AnyObject>
          let feedback = (resDict["feedback"] as AnyObject?) as? String
          self.tts.speak(feedback!)
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
