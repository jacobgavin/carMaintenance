//
//  connectie.swift
//  JsonBackend
//
//  Created by vmware on 28/11/15.
//  Copyright © 2015 vmware. All rights reserved.
//

import Foundation

/*!
*    @class Connectie
*
*    @brief Deze klasse verwerkt de basis API met de server.
*
*    @discussion De connectie maakt een JSON API verbinding met de server.
*
*    @warning De response kan een error zijn, hij vangt deze er nog niet uit.
*
*/

class Connectie
{
    
    var responseFinal = ""
    
    /*!
    *   @brief Post de request en krijgt eventueel een response
    *   @param url Link waar de request naartoe moet.
    *   @return Een NSstring met de response.
    *   @warning De response kan een error zijn!
    */
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
                
                let responseString = NSString(data: data!, encoding: NSUTF8StringEncoding)
                
                completion(result: responseString)
                
                
        }
        task.resume()
        
        
    }

    /*!
    *   @brief Post de request met een body om op de server op te slaan en krijgt eventueel een response
    *   @param url Link waar de request naartoe moet.
    *   @return Een NSstring met de response.
    *   @warning De response kan een error zijn!
    */
    func put(url:String, dataBody : String, completion: ((result:NSString?) -> Void)!)
    {
        let request = NSMutableURLRequest(URL: NSURL(string: url)!)
        request.HTTPMethod = "PUT"
        
        let data = dataBody.dataUsingEncoding(NSUTF8StringEncoding)
        request.HTTPBody = data
        request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        let dataTask = NSURLSession.sharedSession().dataTaskWithRequest(request) {
            data, response, error in
            
            if error != nil {
                print("error=\(error)")
                completion(result: "error")
                return
                //handle error
            }
            
                
                let jsonStr = NSString(data: data!, encoding: NSUTF8StringEncoding)
                print("Parsed JSON: '\(jsonStr)'")
            completion(result: jsonStr)
            
        }
        dataTask.resume()
    }
}
