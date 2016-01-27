//
//  WerkorderDetail.swift
//  CarMaintenance
//
//  Created by vmware on 08/01/16.
//
//

import Foundation


/*!
*    @class WerkorderDetail
*    
*    @brief Object for the Werkorder. Contains all necessary information
*
*    @discussion WerkorderDetail contains the variables: kenteken, merk, model, omschrijving, nummer.
*
*
*/
class WerkorderDetail {
    
    var kenteken : String = ""
    var merk : String = ""
    var model : String = ""
    var omschrijving : String = ""
    var nummer : Int = 0
    
    init(nummer:Int, merk: String, model:String, omschrijving : String, kenteken : String)
    {
        self.nummer = nummer
        self.merk = merk
        self.model = model
        self.omschrijving = omschrijving
        self.kenteken = kenteken
    }
    
    init()
    {}
    
    class func build(json:JSON) -> WerkorderDetail?
    {
        print("hopi")
        if let
            nummer =  json["Nummer"].int,
            omschrijving = json["Omschrijving"].string,
            merk = json["Merk"].string,
            model = json["Model"].string,
            kenteken = json["Kenteken"].string

        {
            return WerkorderDetail(
                nummer : nummer,
                merk: merk,
                model : model,
                omschrijving : omschrijving,
                kenteken : kenteken
                
            )
        }
        else
        {
            print("fout: \(json)")
            return nil
        }
        
    }

    
}