//
//  Artikel.swift
//  carMaintenance
//
//  Created by vmware on 22/01/16.
//  Copyright © 2016 vmware. All rights reserved.
//

import Foundation


class Artikel{
    
    var omschrijving : String = ""
    var artikelID: String = ""
    var aantal: Float = 0.0
    
    
    init(omschrijving: String, artikelID: String, aantal: Float)
    {
        self.omschrijving = omschrijving
        self.artikelID = artikelID
        self.aantal = aantal
        
    }
    
    class func build(json:JSON) -> Artikel?
    {
    
        for(_,object) in json
        {   
            if let omschrijving = json["Omschrijving"].string,
            let artikelID = json["ArtikelId"].string,
            let aantal = json["Aantal"].float
            {
                return Artikel(
                    omschrijving : omschrijving,
                    artikelID : artikelID,
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