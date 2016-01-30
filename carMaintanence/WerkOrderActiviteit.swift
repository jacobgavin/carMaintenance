//
//  WerkOrderActiviteiten.swift
//  carMaintenance
//
//  Created by vmware on 18/01/16.
//  Copyright © 2016 vmware. All rights reserved.
//

import Foundation


class WerkOrderActiviteit{
    var activiteiten : Array<Activiteit?> = Array<Activiteit>()
    var omschrijving : String = ""
    var kenteken : String = ""
    
    init(activiteiten : Array<Activiteit?>, omschrijving: String, kenteken:String)
    {
        self.activiteiten = activiteiten
        self.omschrijving = omschrijving
        self.kenteken = kenteken
    }
    
    init()
    {}
    
    class func build(json:JSON) -> WerkOrderActiviteit?
    {
        
        var activiteiten : Array<Activiteit?> = Array<Activiteit>()
        
        //    print(json)
        
        //    print("omschrijving stuff",json["Omschrijving"].string)
        
        //  print("JSON ACTIVITEITEN ",json["Activiteiten"].array)
        
        if let a = json["Activiteiten"].array
        {
            
            let iets = JSON(a)
            //     print(iets)
            for(_,object) in iets
            {
                // print("Object = ", object)
                let activiteit : Activiteit? = Activiteit.build(object)
                activiteiten.append(activiteit)
            }
        }
        
        
        if let
            
            omschrijving = json["Omschrijving"].string,
            kenteken = json["Kenteken"].string
        {
            //   print("kenteken in werkoder build:" , kenteken)
            return WerkOrderActiviteit(
                activiteiten: activiteiten, omschrijving: omschrijving, kenteken: kenteken
            )
        }
        else
        {
            print("fout: \(json)")
            return nil
        }
        
    }
}