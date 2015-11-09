import Foundation

class Utils {
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