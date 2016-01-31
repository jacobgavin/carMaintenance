//
//  WerkOrderActiviteiten.swift
//  carMaintenance
//
//  Created by vmware on 18/01/16.
//  Copyright © 2016 vmware. All rights reserved.
//

import Foundation

/**
*    @class ActivitiesDetail
*
*    @brief Deze klasse slaat de nodige informatie op can activiteit details.
*
*    @discussion Hij slaat de variabelen activiteiten, omschrijving, code en aantal op.
*
*
*/
class ActivitiesDetail{
    var activities : Array<Activiteit?> = Array<Activiteit?>()
    var omschrijving : String = ""
    var code : String = ""
    var aantal: String = ""
    
    init(activities : Array<Activiteit?>, omschrijving: String, code: String, aantal: String)
    {
        self.activities = activities
        self.omschrijving = omschrijving
        self.code = code
        self.aantal = aantal
    }
    
    init()
    {}
    
    class func build(json:JSON) -> ActivitiesDetail?
    {
        
        var activities : Array<Activiteit?> = Array<Activiteit?>()
        
            print(json)
        
            print("omschrijving stuff",json["Omschrijving"].string)
        
            print("JSON ACTIVITEITEN ",json["Activiteiten"].array)
        
        if let a = json["Activiteiten"].array
        {
            
            let iets = JSON(a)
            //     print(iets)
            for(_,object) in iets
            {
                // print("Object = ", object)
                let activity : Activiteit? = Activiteit.build(object)
                activities.append(activity)
            }
        }
        
        
        if let
            
            omschrijving = json["Omschrijving"].string,
            code = json["BtwCode"].string,
            aantal = json["Aantal"].string
        {
            //   print("kenteken in werkoder build:" , kenteken)
            return ActivitiesDetail(
                activities: activities, omschrijving: omschrijving, code: code, aantal: aantal
            )
        }
        else
        {
            print("fout: \(json)")
            return nil
        }
        
    }
}