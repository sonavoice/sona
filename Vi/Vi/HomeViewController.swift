import UIKit
import QuartzCore

class HomeViewController: UIViewController, SpeechKitDelegate, SKRecognizerDelegate {
  
  var voiceSearch: SKRecognizer?
  
  @IBOutlet var transcript: UILabel!
  @IBOutlet var MicButton: UIButton!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    /* Style Button */
    styleMicButton()
    
    /* Add Button functionality */
    createMicButtonPressFunctionality()
    
    /* Configure SpeechKit Server */
    configureNuance()
    
    /* Add gesture capabilities */
    //addUpSwipeGesture()
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

    self.voiceSearch = SKRecognizer(type: SKSearchRecognizerType, detection: UInt(SKShortEndOfSpeechDetection), language:"eng-USA", delegate: self)
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
  }
  
  func createMicButtonPressFunctionality() {
    self.MicButton.addTarget(self, action: "startListening", forControlEvents: .TouchUpInside)
  }
  
  /* Server & API */
  func attemptToExecuteOnTranscript(transcript: String) {
    
    let apiCallManager = AFHTTPRequestOperationManager()
    
    apiCallManager.GET(
      "http://viapi.io/",
      parameters: nil,
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
    
    //    let earconStart = SKEarcon.earconWithName("earcon_listening.wav") as! SKEarcon
    //    let earconStop = SKEarcon.earconWithName("earcon_done_listening.wav") as! SKEarcon
    //    let earconCancel = SKEarcon.earconWithName("earcon_cancel.wav") as! SKEarcon
    //
    //    SpeechKit.setEarcon(earconStart, forType: UInt(SKStartRecordingEarconType))
    //    SpeechKit.setEarcon(earconStop, forType: UInt(SKStopRecordingEarconType))
    //    SpeechKit.setEarcon(earconCancel, forType: UInt(SKCancelRecordingEarconType))
    
    
  }

  func recognizerDidBeginRecording(recognizer: SKRecognizer!) {
    NSLog("I have started recording")
  }
  
  func recognizerDidFinishRecording(recognizer: SKRecognizer!) {
    NSLog("I have finished recording")
    voiceSearch!.stopRecording()
  }
  
  func recognizer(recognizer: SKRecognizer!, didFinishWithResults results: SKRecognition!) {
    NSLog("Some results! \n %@", results.results)
    transcript.text! = results.firstResult()
  }
  
  func recognizer(recognizer: SKRecognizer!, didFinishWithError error: NSError!, suggestion: String!) {
    NSLog("I errored out with the following error: %@", error)
  }
  
  func audioSessionReleased() {
    NSLog("Audio session released")
  }

  func handlePowerMeter() {
    /* Get power level */
  }
  
}