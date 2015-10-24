import UIKit
import QuartzCore

class HomeViewController: UIViewController {
  
  var stt:SpeechToText = SpeechToText();
  var listening:Bool = false
  
  @IBOutlet var transcript: UILabel!
  @IBOutlet var sunButton: UIButton!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    /* Add sun button */
    createSunPressFunctionality()
    
    /* Add gesture capabilities */
    // No swipe gesturing until exact location of permitted swipe determined
    //addUpSwipeGesture()
    
    /* Configure Watson */
    configureWatson()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  func configureWatson() {
    let conf:STTConfiguration = STTConfiguration()
    
    conf.audioCodec = WATSONSDK_AUDIO_CODEC_TYPE_OPUS
    
    conf.basicAuthUsername = "11a2a0e4-02dd-4b14-812a-bc9ec34efc3a"
    conf.basicAuthPassword = "r5HEtX7J0tqd"
    
    self.stt = SpeechToText.init(config: conf)
  }
  
  func addUpSwipeGesture() {
    let upSwipe = UISwipeGestureRecognizer(target: self, action: Selector("handleSwipes:"))
    upSwipe.direction = .Up
    view.addGestureRecognizer(upSwipe)
  }
  
  func handleSwipes(sender:UISwipeGestureRecognizer) {
    if (sender.direction == .Up) {
      print("Swipe Up")
      listening = !listening
      print("Listening: \(listening)")
      /* Start Watson Listening */
      startListening()
    }
  }
  
  func startListening() {
    self.stt.recognize({ (res: [NSObject:AnyObject]!, err: NSError!) -> Void in
      
      if err == nil {
        if self.stt.isFinalTranscript(res) {
          self.stt.endRecognize()
        }
        self.handleTranscript(self.stt.getTranscript(res))
        self.handlePowerMeter()
        NSLog("@%", self.stt.getTranscript(res))
      } else {
        self.stt.endRecognize()
        NSLog("@%", err.localizedDescription)
      }
    })
  }
  
  func handleTranscript(transcript: String) {
    var oldTranscript = self.transcript.text!
    let newTranscript = transcript
    
    self.transcript.text! = newTranscript
  }
  
  func createSunPressFunctionality() {
    self.sunButton.addTarget(self, action: "buttonPressed", forControlEvents: .TouchUpInside)
    
  }
  
  func buttonPressed() {
    if !listening {
      listening = !listening
      startListening()
    }
  }
  
  func handlePowerMeter() {
    self.stt.getPowerLevel({ (power: Float) -> Void in
      NSLog("Current power level is %@", power)
    })
  }
  
}