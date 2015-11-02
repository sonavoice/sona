import Foundation
import AVFoundation

public class TextToSpeech : NSObject {
  var speaker:AVSpeechSynthesizer;
  
  override init() {
    speaker = AVSpeechSynthesizer()
  }
  
  func speak(text: String) {
    var texttoread:AVSpeechUtterance = AVSpeechUtterance(string: text)
    speaker.speakUtterance(texttoread)
  }
}
