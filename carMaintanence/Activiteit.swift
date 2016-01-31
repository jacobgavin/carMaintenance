//
//  Activiteit.swift
//  carMaintenance
//
//  Created by vmware on 18/01/16.
//  Copyright © 2016 vmware. All rights reserved.
//

import Foundation
/**
*    @class Activiteit
*
*    @brief Object voor de activiteiten, heeft alle informatie die een activiteit nodig heeft.
*
*    @discussion WerkorderDetail heeft de variabelen: artikelen en omschrijving
*
*
*/
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
        if let temp = json["Artikelen"].array
        {
            
            let tempjson = JSON(temp)
            for(_,object) in tempjson
            {
                let artikel : Artikel? = Artikel.build(object)
                artikels.append(artikel)
            }
        }
        for(_,_) in json
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