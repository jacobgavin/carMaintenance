//
//  Monteur.swift
//  CarMaintenance
//
//  Created by vmware on 03/12/15.
//
//

import Foundation
class Monteur
{
    var id : Int = 0
    var code : String = ""
    var naam : String = ""
    
    init(id:Int, code: String, naam:String)
    {
        self.id = id
        self.code = code
        self.naam = naam
    }
    
    init()
    {}
    
    class func build(json:JSON) -> Monteur?
    {
        if let
            id =  json["ID"].int,
            code = json["Code"].string,
            naam = json["Naam"].string
        {
            return Monteur(
                id : id,
                code: code,
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