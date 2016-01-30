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
    var artikels: Array<Artikel?> = Array<Artikel>()
    
    
    init(omschrijving: String, artikels: Array<Artikel?>)
    {
        self.omschrijving = omschrijving
        self.artikels = artikels
    }
    
    class func build(json:JSON) -> Activiteit?
    {
        var artikels : Array<Artikel?> = Array<Artikel>()
        if let a = json["Artikelen"].array
        {
            
            var iets = JSON(a)
            //     print(iets)
            for(_,object) in iets
            {
                // print("Object = ", object)
                let artikel : Artikel? = Artikel.build(object)
                artikels.append(artikel)
            }
        }
        for(_,object) in json
        {
            if let omschrijving = json["Omschrijving"].string
            {
                return Activiteit(
                    omschrijving : omschrijving,
                    artikels : artikels)
                
            }
            else
            {
                print("fout in activiteit: \(json)")
            }
        }
        return nil
    }
}