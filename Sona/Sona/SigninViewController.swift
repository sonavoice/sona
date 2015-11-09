import UIKit
import WebKit

class SigninViewController: UIViewController, WKNavigationDelegate {
  
  var appname = String()
  var webView = WKWebView()
  
  let appManager = AppManager()
  let utils = Utils()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.webView = WKWebView(frame: CGRectMake(0, 0, UIScreen.mainScreen().bounds.width, UIScreen.mainScreen().bounds.height))
    self.webView.navigationDelegate = self
    
    let address = "https://sonavoice.com/authenticate/" + self.appname
    self.webView.loadRequest(NSURLRequest(URL: NSURL(string: address)!))
    
    self.view.addSubview(webView)
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  // WKNavigationDelegates
  func webView(webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
    NSLog("Opening web page")
  }
  
  func webView(webView: WKWebView, didFailNavigation navigation: WKNavigation!, withError error: NSError) {
    NSLog("Failed Navigation %@", error.localizedDescription)
  }
  
  func webView(webView: WKWebView, didFinishNavigation navigation: WKNavigation!) {
    if utils.matchesForRegexInText("done", text: webView.URL?.absoluteString).count >= 1 {
      webView.evaluateJavaScript("stringedAuth", completionHandler: {(auth, error) in
        let passportDict = self.utils.JSONParseDictionary(auth! as! String)
        
        /* Save in core data */
        self.appManager.savePassport(self.appname, passport: passportDict)
        
        self.dismissViewControllerAnimated(true, completion: nil)
      })
    }
  }
  
}
