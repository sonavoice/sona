import UIKit
import QuartzCore

class HomeGestureViewController: UIViewController {
  
  var stt:SpeechToText = SpeechToText();
  var listening:Bool = false
  var editedTranscript:String = ""
  
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
    
    let totalString = self.editedTranscript
    let newTranscriptString = transcript
    
    let totalStringAsArray = totalString.characters.split{$0 == " " || $0 == ","}.map(String.init)
    let newTranscriptStringAsArray = newTranscriptString.characters.split{$0 == " " || $0 == ","}.map(String.init)
    
    var i = 0
    var temp = ""
    
    for word in newTranscriptStringAsArray {
      if i >= totalStringAsArray.count {
        temp = ""
      } else {
        temp = totalStringAsArray[i]
      }
      if ( word != temp){
        /* Not working :( */
        self.transcript.text = "\(temp)  \(word)";
      }
      ++i
    }
  }
  
  func createSunPressFunctionality() {
    self.sunButton.addTarget(self, action: "buttonPressed", forControlEvents: .TouchUpInside)
    
  }
  
  func addPulseAnimation(powerLevel: Float) {
    let scaleAnimation:CABasicAnimation = CABasicAnimation(keyPath: "transform.scale")
    
    scaleAnimation.duration = 0.3
    scaleAnimation.repeatCount = 0.0
    scaleAnimation.autoreverses = false
    scaleAnimation.fromValue = (abs(powerLevel) / 100);
    scaleAnimation.toValue = 1.0;
    
    self.sunButton.layer.addAnimation(scaleAnimation, forKey: "scale")
  }
  
  func buttonPressed() {
    if !listening {
      listening = !listening
      startListening()
    }
  }
  
  func handlePowerMeter() {
    self.stt.getPowerLevel({ (power: Float) -> Void in
      self.addPulseAnimation(power)
    })
  }

}