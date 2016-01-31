//
//  Monteur.swift
//  CarMaintenance
//
//  Created by vmware on 03/12/15.
//
//

import Foundation
/**
*    @class Monteur
*    
*    @brief Monteur is het standaard object van gebruikers.
*
*    @discussion Monteur heeft al de belangrijke informatie: id, code en naam. Zodat ze kunnen beginnen met inklokken en werken
*
*
*/
class Monteur
{
    var id : Int = 0
    var code : String = ""
    var naam : String = ""
    var active : Bool = false
    
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
    
    func set_active(ID: Int) {
        self.active = true
    }
}