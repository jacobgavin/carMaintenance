//
//  connectie.swift
//  JsonBackend
//
//  Created by vmware on 28/11/15.
//  Copyright © 2015 vmware. All rights reserved.
//

import Foundation

class Connectie
{
    
    var responseFinal = ""
    
    func post(url : String, completion: ((result:NSString?) -> Void)!)
    {
        
        let request = NSMutableURLRequest(URL: NSURL(string: url)!)
        request.HTTPMethod = "GET"
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request)
            {
                data, response, error in
                
                if error != nil
                {
                    print("error=\(error)")
                    completion(result: "error")
                    return
                }
                
                //print("response = \(response)")
                
                let responseString = NSString(data: data!, encoding: NSUTF8StringEncoding)
                
                completion(result: responseString)
                
                
        }
        task.resume()
        
        
    }
    
    
    
}