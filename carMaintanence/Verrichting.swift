//
//  Artikel.swift
//  carMaintenance
//
//  Created by vmware on 22/01/16.
//  Copyright © 2016 vmware. All rights reserved.
//

import Foundation


class Verrichting{
    
    var omschrijving : String = ""
    var BtwCode: Float = 0.0
    var aantal: Float = 0.0
    
    
    init(omschrijving: String, code: Float, aantal: Float)
    {
        self.omschrijving = omschrijving
        self.BtwCode = code
        self.aantal = aantal
        
    }
    
    class func build(json:JSON) -> Verrichting?
    {
    
        for(_,object) in json
        {   
            if let omschrijving = json["Omschrijving"].string,
            let code = json["BtwPercentage"].float,
            let aantal = json["Aantal"].float
            {
                return Verrichting(
                    omschrijving : omschrijving,
                    code : code,
                    aantal: aantal
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