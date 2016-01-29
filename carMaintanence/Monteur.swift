//
//  Monteur.swift
//  CarMaintenance
//
//  Created by vmware on 03/12/15.
//
//

import Foundation
/*!
*    @class Monteur
*    
*    @brief Monteur is the main object for the users.
*
*    @discussion Monteur contains all the neccessary information like name, passcode and id, in order to login and start working.
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