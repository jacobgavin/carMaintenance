//
//  WerkOrderActiviteiten.swift
//  carMaintenance
//
//  Created by vmware on 18/01/16.
//  Copyright © 2016 vmware. All rights reserved.
//

import Foundation


class WerkOrderActiviteit{
    
    var activiteiten : Array<Any> = []
    var opmerkingIntern : String = ""
    var opmerkingExtern : String = ""
    var omschrijving : String = ""
    
    init(activiteiten : Array<Any>, omschrijving : String, opmerkingIntern:String, opmerkingExtern:String)
    {
        self.activiteiten = activiteiten
        self.opmerkingIntern = opmerkingIntern
        self.opmerkingExtern = opmerkingExtern
        self.omschrijving = omschrijving
    }
    
    init()
    {}
    
    class func build(json:JSON) -> WerkOrderActiviteit?
    {
        if let
            activiteiten =  json["Activiteiten"].arrayObject,
            opmerkingExtern = json["OpmerkingExtern"].string,
            opmerkingIntern = json["OpmerkingIntern"].string,
            omschrijving = json["Omschrijving"].string
            
        {
            print(activiteiten)
            return WerkOrderActiviteit(
                activiteiten : activiteiten,
                omschrijving : omschrijving,
                opmerkingIntern: opmerkingIntern,
                opmerkingExtern: opmerkingExtern
            )
        }
        else
        {
            print("fout: \(json)")
            return nil
        }
        
    }
}