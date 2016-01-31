//
//  BeschikbareVestiging.swift
//  carMaintenance
//
//  Created by vmware on 29/01/16.
//  Copyright © 2016 vmware. All rights reserved.
//

import Foundation

/*!
*    @class beschikbareVestiging
*
*    @brief alle beschikbare vestigingen worden opgeslagen.
*
*    @discussion Beschikbare vestiging heeft de informatie: id en naam.
*
*
*/
class BeschikbareVestiging
{
    var id : String = ""
    var naam : String = ""
    
    
    init(){}
    
    init(id:String, naam:String)
    {
        self.id = id
        self.naam = naam
    }
    
    class func build(json:JSON) -> BeschikbareVestiging?
    {
        if let
            id =  json["Id"].string,
            naam = json["Name"].string
        {
            return BeschikbareVestiging(
                id : id,
                naam : naam
            )
        }
        else
        {
            print("fout: \(json)")
            return nil
        }
        
    }

}