import UIKit

protocol HttpProtocol{
    func didRecieveResults(results:NSDictionary)
}

class HttpController:NSObject{
    
    var delegat:HttpProtocol?
    
    //function
    func OnSearch(url:String){
        var nsUrl:NSURL=NSURL(string: url)!
        var request:NSURLRequest=NSURLRequest(URL: nsUrl)
        NSURLConnection.sendAsynchronousRequest(request,queue: NSOperationQueue.mainQueue(),completionHandler:{(response:NSURLResponse!,data:NSData!,error:NSError!)->Void in
        
            var jsonResult:NSDictionary=NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil) as NSDictionary
        
            self.delegat?.didRecieveResults(jsonResult)
            
            })
    }
    
}