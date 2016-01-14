//
//  MainJson.swift
//  JsonBackend
//
//  Created by vmware on 28/11/15.
//  Copyright © 2015 vmware. All rights reserved.
//



import Foundation

/*!
*    @class MainJson
*    @brief This class handles all the API functions between the app and the server.
*    @discussion This class contains all the functions that get information from the API.
*    
*   TODO: apparaatid moet worden doorgegeven vanuit SelecteerpersoonView
*/
class MainJson
{
    var connectie : Connectie
    var sessieId : String = ""
    var appleID : String = ""
    let siteUrl = "http://92.66.29.229/api/"
    let vestiging = "V001"
    let date1 = "2015-11-01T00:00:00"
    let date2 = "2015-11-03T00:00:00"
    

    
    init()
    {
        connectie = Connectie()
        
        //     var werkOrderStatus = getWerkorderStatus(sessieId)
        
        // toJsonTest(werkOrderStatus)
        // print(werkOrderStatus)
        
        // toJsonTest(getMonteurs(sessieId))
    }
    
    /*!
    * @brief Sets the session ID
    */
    func setSessieID()
    {
        sessieId = getSessieId()
        getMonteurs(sessieId)
        getWerkorder(sessieId)
    }
    
    func setAppleID(appleid : String)
    {
        appleID = appleid 
    }
    /*!
    * @brief Get the current session ID.
    * @return returns the session ID as a String.
    */
    func getSessieId() -> String
    {
        var sessieId = ""
        connectie.post(siteUrl+"WinCar/GetSessieIdVoorApparaat?apparaatId="+ appleID + "&vestigingId=" + vestiging) { (result) -> Void in
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
    

    /*!
    * @brief Get all the Monteurs on the current vestiging.
    * 
    */
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
        
        return jsonNaarMonteurs(monteurs)
    }
    
    //geen json nodig voor response, server geeft direct al een boolean
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
        var monteurs : Array<Monteur> = Array<Monteur>()
        if let json = result.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false) // String --> NSData
        {
            let json2 = JSON(data: json) // NSData --> JSON object
            for(index,object) in json2
            {
                var monteur = Monteur.build(object)
                monteurs.append(monteur!)
            }
        }
        return monteurs
    }
    
    func getWerkorder(sessieId: String) -> Array <WerkorderDetail>
    {
        var werkorders = ""
        connectie.post(siteUrl+"WplWerkorder/GetOpVestiging?sessieId=\(sessieId)&vestiging=\(vestiging)&statusFilter=\(2)&datum=\(date1)&eindDatum=\(date2)") { (result) ->
            Void in
            if let constWerkorders = result as? String{
                werkorders = constWerkorders
            }
        }
        while(werkorders == ""){}
        return jsonNaarWerkorderDetails(werkorders)
    }
    
    func jsonNaarWerkorderDetails(werkOrderDetailsJson : String) -> Array <WerkorderDetail>
    {
        var werkOrderDetails : Array<WerkorderDetail> = Array<WerkorderDetail>()
        
        
        if let json = werkOrderDetailsJson.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false) // String --> NSData
        {
            let json2 = JSON(data: json) // NSData --> JSON object
            
            for(index,object) in json2
            {
                
                var werkOrderDetail = WerkorderDetail.build(object)
                print(werkOrderDetail!.kenteken)
                werkOrderDetails.append(werkOrderDetail!)
                
            }
            
        }
        
        
        
        return werkOrderDetails
    }
    
    
    //    func getStandaardActiviteiten(sessieId: String) -> String
    //    {
    //    var standaardActiviteiten = ""
    //        connectie.post(siteUrl + "WplWerkorder/GetStandaardActiviteiten?sessieId="+sessieId){ (result) ->
    //            Void in
    //            if let constActiviteiten = result as? String{
    //                standaardActiviteiten = constActiviteiten
    //            }
    //        }
    //        while(standaardActiviteiten == ""){}
    //        return standaardActiviteiten
    //    }
    
    //    func getWerkorderVestiging(sessieId: String) -> String werkt niet
    //    {
    //        var werkorderVestiging = ""
    //        connectie.post(siteUrl + "WplWerkorder/GetOpVestiging?sessieId=" + sessieId + "&vestiging=V001&statusFilter=ONLINE"){ (result) ->
    //            Void in
    //            if let constWerkorderVestiging = result as? String{
    //                werkorderVestiging = constWerkorderVestiging
    //            }
    //        }
    //        while(werkorderVestiging == ""){}
    //        return werkorderVestiging
    //    }
    
    //    func getWerkorderStatus(sessieId: String) -> String
    //    {
    //        var werkorderStatus = ""
    //        connectie.post(siteUrl+"WplWerkorder/GetWerkorderStatussen?sessieId=" + sessieId) { (result) ->
    //            Void in
    //            if let constWerkorderStatus = result as? String{
    //                werkorderStatus = constWerkorderStatus
    //            }
    //        }
    //        while(werkorderStatus == ""){}
    //        return werkorderStatus
    //    }
    
    
}