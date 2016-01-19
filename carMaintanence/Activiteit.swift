//
//  Activiteit.swift
//  carMaintenance
//
//  Created by vmware on 18/01/16.
//  Copyright © 2016 vmware. All rights reserved.
//

import Foundation

class Activiteit{
    
    var omschrijving : String = ""
    
    init(omschrijving: String)
    {
        self.omschrijving = omschrijving
    }
    
    class func build(json:JSON) -> Activiteit?
    {
        
        
        for(_,object) in json
        {
            if let omschrijving = json["Omschrijving"].string
            {
                return Activiteit(
                    omschrijving : omschrijving
                )
            }
            else
            {
                print("fout in activiteit: \(json)")
            }
        }
        return nil
    }
}