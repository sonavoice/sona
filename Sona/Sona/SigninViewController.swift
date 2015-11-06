import UIKit
class SigninViewController: UIViewController, UIWebViewDelegate {
  var appname: String = ""
  let appManager = AppManager()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let webView:UIWebView = UIWebView(frame: CGRectMake(0, 0, UIScreen.mainScreen().bounds.width, UIScreen.mainScreen().bounds.height))
    
    let address = "https://sonavoice.com/authenticate/" + self.appname
    webView.loadRequest(NSURLRequest(URL: NSURL(string: address)!))
    webView.delegate = self
    
    self.view.addSubview(webView)
  }
  
  func webViewDidFinishLoad(webView: UIWebView) {
    if matchesForRegexInText("done$", text: webView.request?.mainDocumentURL?.absoluteString).count >= 1 {
      let auth = webView.stringByEvaluatingJavaScriptFromString("stringedAuth")
      let passportDict = JSONParseDictionary(auth!)
      self.appManager.savePassport(self.appname, passport: passportDict)
      self.dismissViewControllerAnimated(true, completion: nil)
    }
  }
  
  /* Utils */
  
  func JSONParseDictionary(string: String) -> [String: AnyObject]{
    
    if let data = string.dataUsingEncoding(NSUTF8StringEncoding){
      do{
        if let dictionary = try NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers) as? [String: AnyObject]{
          return dictionary
        }
      }catch {
        print("error")
      }
    }
    return [String: AnyObject]()
  }
  
  func matchesForRegexInText(regex: String!, text: String!) -> [String] {
    do {
      let regex = try NSRegularExpression(pattern: regex, options: [])
      let nsString = text as NSString
      let results = regex.matchesInString(text,
        options: [], range: NSMakeRange(0, nsString.length))
      return results.map { nsString.substringWithRange($0.range)}
    } catch let error as NSError {
      print("invalid regex: \(error.localizedDescription)")
      return []
    }
  }
}

func JSONParseDictionary(string: String) -> [String: AnyObject]{
  if let data = string.dataUsingEncoding(NSUTF8StringEncoding){
    do{
      if let dictionary = try NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers) as? [String: AnyObject]{
        return dictionary
      }
    }catch {
      print("error")
    }
  }
  return [String: AnyObject]()
}
