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
*    @brief Deze klasse handelt alle communicatie tussen de server en de app af
*    @discussion Deze klasse heeft alle functies die informatie van de server krijgen.
*    @warning TODO: apparaatid moet worden doorgegeven vanuit SelecteerpersoonView, die wordt daar al wel een aangemaakt. ook een un-hardcode Vestiging
*   
*/
class MainJson
{
    let appleIdCanBeRegistered = false
    var connectie : Connectie
    var sessieId : String = ""
    var appleID : String = "IOS_01_V001"
    let siteUrl = "http://92.66.29.229/api/"
    var vestiging = "V001"
    let date1 = "2014-01-01T00:00:00"
    let date2 = "2016-08-19T00:00:00"
    var ingeklokt = false
    var actDetails: String = ""
    
    init()
    {
        connectie = Connectie()
    }
    
    /*!
    * @brief Sets the session ID
    */
    func setSessieID()
    {
        sessieId = getSessieId()
    }
    
    /*!
        @brief Slaat de vestiging op
    */
    func setVestiging(v:String){
        vestiging = v
    }
    
    /*!
        @brief Slaat het apple ID op
    */
    func setAppleID(appleid : String)
    {
        if (appleIdCanBeRegistered == true){
            appleID = appleid
        }
    }
    
    /*!
    * @brief Krijgt het huidige sessie ID.
    * @return returns de sessie ID als een String.
    */
    func getSessieId() -> String
    {
        if self.sessieId==""{
            var sessieId = ""
            connectie.post(siteUrl+"WinCar/GetSessieIdVoorApparaat?apparaatId=\(appleID)&vestigingId=" + vestiging) { (result) -> Void in
                if let constId = result as? String {
                    var tempId = constId
                    tempId.removeAtIndex(tempId.startIndex)
                        tempId.removeAtIndex(tempId.endIndex.predecessor())
                sessieId = tempId
                }
            }
            while(sessieId == ""){}
            self.sessieId = sessieId
            return sessieId
        }
        print(self.sessieId)
        return self.sessieId
    }
    

    /*!
    * @brief krijgt alle Monteurs op de huidige vestiging.
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
    
    /*!
        @brief valideert de pincode voor een monteur hier heb je geen json voor nodig want het return true of false
        @return true of false aan de hand van de juiste pincode of niet
        @params sessieID is de huidige sessieID
                monteurcode is de code van de monteur die geselecteerd is
                vestiging is de vestiging gekozen(nu nog hardcoded)
                pincode is de ingevoerde pincode
    */
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
    
    /*!
        @brief functie slaat een nieuwe activiteit op, op de server
        @return none
        @params kenteken is het kenteken waarvoor je een nieuwe activiteit aanmaakt
                sessieID is het huidige sessieID
                omschrijving is de meegegeven omschrijving door de monteur
                id is de id die meegegeven moet worden voor de server
                code is de company code in de api
    */
    func opslaanActiviteit(kenteken: String, sessieId:String, omschrijving : String, id : Int, code : String )
    {
        let postData = NSMutableData(data: code.dataUsingEncoding(NSUTF8StringEncoding)!)
        postData.appendData("&Id=\(id)".dataUsingEncoding(NSUTF8StringEncoding)!)
        postData.appendData("&Omschrijving=\(omschrijving)".dataUsingEncoding(NSUTF8StringEncoding)!)
        postData.appendData("&Code=\(code)".dataUsingEncoding(NSUTF8StringEncoding)!)
        
        let dataBody = NSString(data: postData, encoding: NSUTF8StringEncoding) as! String
        var temp = ""
        
        connectie.put(siteUrl + "WplWerkorder/MaakActiviteitUitServiceActie?kenteken="+kenteken+"&sessieId="+sessieId, dataBody: dataBody)
            {
                (result) -> Void in
                if let _ = result
                {
                    temp = result as! String // if statement checkt de optional al dus dit kan veilig
                }
        }
        while(temp == ""){}
    }
    
    /*!
        @brief schrijft het object wat gekregen wordt van de server om naar een lijst van monteurs
        @return een lijst van monteurs
        @params een string van alle monteurs verkregen van de server
    */
    func jsonNaarMonteurs(result : String) -> Array<Monteur>
    {
        var monteurs : Array<Monteur> = Array<Monteur>()
        if let json = result.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false) // String --> NSData
        {
            let json2 = JSON(data: json) // NSData --> JSON object
            for(_, object) in json2
            {
                let monteur = Monteur.build(object)
                monteurs.append(monteur!)
            }
        }
        return monteurs
    }
    
    /*!
        @brief vraagt de beschikbare vestigingen op aan de server
        @return een array van de beschikbare vestigingen
        @params SessieID is nodig om de beschikbare vestigingen op te vragen
    */
    func getBeschikbareVestigingen(sessieId : String) -> Array<BeschikbareVestiging>
    {
        var vestigingen = ""
        connectie.post(siteUrl+"WinCar/GetBeschikbareVestigingen?sessieId=\(sessieId)")
            {
                (result) -> Void in
                if let response = result as? String
                {
                    vestigingen = response
                }
        }
        while(vestigingen == ""){}
        return jsonNaarBeschikbareVestigingen(vestigingen)
        
    }
    
    /*!
        @brief de beschikbare vestigingen worden in een array gezet
        @return een Array van beschikbare vestigingen
        @params vestigingenJson is een string van alle beschikbare vestigingen
    */
    func jsonNaarBeschikbareVestigingen(vestigingenJson : String) -> Array<BeschikbareVestiging>
    {
        var vestigingenLijst : Array<BeschikbareVestiging> = Array<BeschikbareVestiging>()
        
        if let json = vestigingenJson.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false) // String --> NSData
        {
            let json2 = JSON(data: json) // NSData --> JSON object
            for(_, object) in json2
            {
                let vestiging = BeschikbareVestiging.build(object)
                vestigingenLijst.append(vestiging!)
                print(vestiging!.id,vestiging!.naam)
            }
        }
        return vestigingenLijst
        
    }
    
    /*!
        @brief vraagt de werkorders op bij een vestiging
        @return alle werkorders bij een vestiging in een lijst
        @params sessieID is het huidige sessieID
                monteurcode is de monteurcode van de ingelogde monteur
        @TODO Datums zijn gehardcode, voor 2016 stonden er geen werkorders in
    */
    func getWerkorder(sessieID: String, monteurCode: String) -> Array <WerkorderDetail>
    {
        var werkorders = ""
        connectie.post(siteUrl+"WplWerkorder/GetOpVestiging?sessieId=\(sessieId)&vestiging=\(vestiging)&statusFilter=\(2)&datum=\(date1)&eindDatum=\(date2)") { (result) ->
            Void in
            if let constWerkorders = result as? String{
                werkorders = constWerkorders
            }
        }
        while(werkorders == ""){}
        return jsonNaarWerkorderDetails(werkorders, monteurCode: monteurCode)
    }
    
    /*!
        @brief schrijft de string met werkorders om naar een array van werkorderdetail
        @return een array van werkorder details
        @params WerkorderDetailsJson is een string van de informatie die op de server verkregen is
                Monteurcode is een string van de code van de huidige monteur
    */
    func jsonNaarWerkorderDetails(werkOrderDetailsJson : String, monteurCode: String) -> Array <WerkorderDetail>
    {
        var werkOrderDetails : Array<WerkorderDetail> = Array<WerkorderDetail>()
        
        
        if let json = werkOrderDetailsJson.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false) // String --> NSData
        {
            let json2 = JSON(data: json) // NSData --> JSON object
            
            for(_,object) in json2
            {
                
                let werkOrderDetail = WerkorderDetail.build(object)
               
                if (werkOrderDetail?.monteurCode == monteurCode) {
                    werkOrderDetails.append(werkOrderDetail!)
                }
                
            }
            
        }
        
        return werkOrderDetails
    }
    
    /*!
        @brief vraagt de lijst op van overige werkorders, dit zijn alle werkorders die niet van de ingelogde monteur zijn, en geeft een array terug
        @return een array van werkorderdetail
        @params sessieID is het huidige sessieID
                monteurCode is de monteurcode van de huidige monteur
    */
    func getOtherWerkorders(sessieID: String, monteurCode: String) -> Array <WerkorderDetail>
    {
        var werkorders = ""
        connectie.post(siteUrl+"WplWerkorder/GetOpVestiging?sessieId=\(sessieId)&vestiging=\(vestiging)&statusFilter=\(2)&datum=\(date1)&eindDatum=\(date2)") { (result) ->
            Void in
            if let constWerkorders = result as? String{
                werkorders = constWerkorders
            }
            
        }
        while(werkorders == ""){}
        return jsonOtherWerkorderDetails(werkorders, monteurCode: monteurCode)
    }
    
    /*!
        @brief Schrijft de string van werkorderdetails om naar een array
        @return een array van werkorderdetails
        @params WerkOrderDetailsJson is een string die op de server verkregen is met alle werkorders
                monteurcode is de code van de huidige monteur
    */
    func jsonOtherWerkorderDetails(werkOrderDetailsJson : String, monteurCode: String) -> Array <WerkorderDetail>
    {
        var werkOrderDetails : Array<WerkorderDetail> = Array<WerkorderDetail>()
        
        
        if let json = werkOrderDetailsJson.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false) // String --> NSData
        {
            let json2 = JSON(data: json) // NSData --> JSON object
            
            for(_,object) in json2
            {
                
                let werkOrderDetail = WerkorderDetail.build(object)

                if (werkOrderDetail?.monteurCode != monteurCode) {
                    werkOrderDetails.append(werkOrderDetail!)
                }
                
            }
            
        }
        
        return werkOrderDetails
    }
    
    /*!
        @brief Vraagt alle Activiteiten op bij een ordernummer
        @return WerkOrderActiviteit waarin de activeiten bij een werkorder staan
        @params sessieID is een string van het huidige sessieID
                orderNummer is het rdernummer van de geselecteerde werkorder
    */
    func getWerkOrderActiviteitenopKenteken(sessieID: String, orderNummer: Int) -> WerkOrderActiviteit
    {
        var werkOrderActiviteiten = ""
       
        connectie.post(siteUrl+"WplWerkorder/GetWerkorder?vestiging=\(self.vestiging)&ordernummer=\(orderNummer)&sessieId=\(sessieID)") { (result) ->
            Void in
            if let constWerkorderActiviteiten = result as? String{
                werkOrderActiviteiten = constWerkorderActiviteiten
            }
        }
        while(werkOrderActiviteiten == ""){}
        return jsonNaarWerkorderActiviteiten(werkOrderActiviteiten)
    }
    
    /*!
        @brief Schrijft de string die verkregen is op de server om naar WerkOrderActiviteit
        @return WerkOrderActiviteit waarin de activeiten bij een werkorder staan
        @params WerkOrderDetailsJson is een string van de details van een werkorder
    */
    func jsonNaarWerkorderActiviteiten(werkOrderDetailsJson : String) -> WerkOrderActiviteit
    {
        var werkOrderActiviteiten : WerkOrderActiviteit = WerkOrderActiviteit()
        
        if let json = werkOrderDetailsJson.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false) // String --> NSData
        {
            let json2 = JSON(data: json) // NSData --> JSON object
            if let werkOrderActiviteit = WerkOrderActiviteit.build(json2)
                {
                werkOrderActiviteiten = werkOrderActiviteit
                }
        }
        return werkOrderActiviteiten
    }
    
    /*!
        @brief  Vraagt de details op van activiteiten
        @return ActivitiesDetail wat bestaat uit de details van activiteiten van een werkorder
        @params sessieID is het huidige sessieID 
                werkOrderNumber is het order nummer waarvan je de activiteiten wilt weten
    */
    func getActivityDetails(sessieID: String, workOrderNumber: Int) -> ActivitiesDetail {
        var activities = ""
        connectie.post(siteUrl+"WplWerkorder/GetActiviteitDetails?sessieId=\(sessieID)&Werkordernummer=\(workOrderNumber)") { (result) ->
            Void in
            if let activityDetails = result as? String{
                print(activityDetails)
                activities = activityDetails
            }
        }
        return jsonToActivityDetails(activities)
    }
    
    /*!
        @brief Schrijft de string met activiteitdetails om naar activitiesDetail
        @return ActivitietsDetail
        @params activityDetails is een string van de details van de activiteiten die op de server verkregen is
    */
    func jsonToActivityDetails(activityDetails : String) -> ActivitiesDetail
    {
        var activities : ActivitiesDetail = ActivitiesDetail()
        
        if let json = activityDetails.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false) // String --> NSData
        {
            let json2 = JSON(data: json) // NSData --> JSON object

            if let activityJson = ActivitiesDetail.build(json2)
            {
                activities = activityJson
            }
        }
        return activities
    }
}