//
//  MainJson.swift
//  JsonBackend
//
//  Created by vmware on 28/11/15.
//  Copyright © 2015 vmware. All rights reserved.
//

import Foundation

class MainJson
{
    var connectie : Connectie
    var sessieId : String = ""
    let siteUrl = "http://92.66.29.229/api/"
    let vestiging = "V001"
    
    init()
    {
        connectie = Connectie()
        sessieId = getSessieId()
        //     var werkOrderStatus = getWerkorderStatus(sessieId)
        var getmonteurs = getMonteurs(sessieId)
        
        // toJsonTest(werkOrderStatus)
        // print(werkOrderStatus)
        
        // toJsonTest(getMonteurs(sessieId))
    }
    
    func getSessieId() -> String
    {
        var sessieId = ""
        connectie.post(siteUrl+"WinCar/GetSessieIdVoorApparaat?apparaatId=IOS_01_V001&vestigingId=V001") { (result) -> Void in
            if let constId = result as? String {
                var tempId = constId
                tempId.removeAtIndex(tempId.startIndex)
                tempId.removeAtIndex(tempId.endIndex.predecessor())
                sessieId = tempId
            }
        }
        while(sessieId == ""){}
        return sessieId
    }
    
    func getStandaardActiviteiten(sessieId: String) -> String
    {
        var standaardActiviteiten = ""
        connectie.post(siteUrl + "WplWerkorder/GetStandaardActiviteiten?sessieId="+sessieId){ (result) ->
            Void in
            if let constActiviteiten = result as? String{
                standaardActiviteiten = constActiviteiten
            }
        }
        while(standaardActiviteiten == ""){}
        return standaardActiviteiten
    }
    
    func getWerkorderVestiging(sessieId: String) -> String
    {
        var werkorderVestiging = ""
        connectie.post(siteUrl + "WplWerkorder/GetOpVestiging?sessieId=" + sessieId + "&vestiging=V001&statusFilter=ONLINE"){ (result) ->
            Void in
            if let constWerkorderVestiging = result as? String{
                werkorderVestiging = constWerkorderVestiging
            }
        }
        while(werkorderVestiging == ""){}
        return werkorderVestiging
    }
    
    func getWerkorderStatus(sessieId: String) -> String
    {
        var werkorderStatus = ""
        connectie.post(siteUrl+"WplWerkorder/GetWerkorderStatussen?sessieId=" + sessieId) { (result) ->
            Void in
            if let constWerkorderStatus = result as? String{
                werkorderStatus = constWerkorderStatus
            }
        }
        while(werkorderStatus == ""){}
        return werkorderStatus
    }
    
    func getMonteurs(sessieId: String) -> Array<Monteur>
    {
        var monteurs = ""
        
        connectie.post(siteUrl + "WplMonteur/GetMonteurs?sessieId=" + sessieId + "&vestiging=" + vestiging)
            {
                (result) -> Void in
                if let constMonteurs = result as? String
                {
                    monteurs = constMonteurs
                }
        }
        while(monteurs == ""){}
        
        print("hoi"+monteurs)
        
        return jsonNaarMonteurs(monteurs)
    }
    
    //geen json nodig voor response, sever geeft direct al een boolean
    func valideerPincodeVoorMonteur(sessieId : String, monteurCode : String, vestiging : String, pincode : String) -> Bool
    {
        var gevalideerd = false
        var temp = ""
        
        
        connectie.post(siteUrl + "WplMonteur/ValideerPincodeVoorMonteur?sessieId="+sessieId+"&monteurCode="+monteurCode+"&vestiging="+vestiging+"&pincode="+pincode)
            {
                (result) -> Void in
                if let const = result
                {
                    gevalideerd = const.boolValue
                    temp = result as! String // if statement checkt de optional al dus dit kan veilig
                }
        }
        while(temp == ""){}
        
        return gevalideerd
    }
    
    func jsonNaarMonteurs(result : String) -> Array<Monteur>
    {
        // var json = JSON(result )
        var monteurs : Array<Monteur> = Array<Monteur>()
        
        if let json = result.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false) // String --> NSData
        {
            let json2 = JSON(data: json) // NSData --> JSON object
            
            for(index,object) in json2
            {
                //print(object)
                var monteur = Monteur.build(object)
                
                monteurs.append(monteur!)
            }
            
        }
        
        //        for object in monteurs
        //        {
        //            print(object.naam)
        //        }
        
        return monteurs
        
        
        //      if let monteurs = (json["{"].array?.map { return Monteur.build($0) })
        //    {print ("Monteurs: " + monteurs.description)}
        
        
    }
    
    
    
}