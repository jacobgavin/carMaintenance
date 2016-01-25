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
    var verrichting: Array<Verrichting?> = Array<Verrichting>()
    
    
    init(omschrijving: String, verrichting: Array<Verrichting?>)
    {
        self.omschrijving = omschrijving
        self.verrichting = verrichting
    }
    
    class func build(json:JSON) -> Activiteit?
    {
        var verrichting : Array<Verrichting?> = Array<Verrichting>()
        if let a = json["Verrichtingen"].array
        {
            
            var iets = JSON(a)
            //     print(iets)
            for(_,object) in iets
            {
                // print("Object = ", object)
                let verricht : Verrichting? = Verrichting.build(object)
                verrichting.append(verricht)
            }
        }
        for(_,object) in json
        {
            if let omschrijving = json["Omschrijving"].string
            {
                return Activiteit(
                    omschrijving : omschrijving,
                    verrichting : verrichting)
                
            }
            else
            {
                print("fout in activiteit: \(json)")
            }
        }
        return nil
    }
}