import Foundation
import AVFoundation

public class TextToSpeech : NSObject {
  var speaker:AVSpeechSynthesizer;
  
  override init() {
    speaker = AVSpeechSynthesizer()
  }
  
  func speak(text: NSString) {
    var text:AVSpeechUtterance = AVSpeechUtterance()
    speaker.speakUtterance(text)
  }
}
