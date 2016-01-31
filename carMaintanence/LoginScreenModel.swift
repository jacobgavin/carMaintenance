//
//  LoginScreenModel.swift
//  carMaintanence
//
//  Created by vmware on 20/10/15.
//  Copyright © 2015 vmware. All rights reserved.
//

import Foundation

/**
    *   @class LoginScreenModel
    *   @brief Model Controleert de ingevoerde pincode vanout loginschermcontroller.
    *   @warning TODO: Werkt op dit moment alleen op vestiging 1, vestiging is dus nog gehardcode en moet aangepast worden.

*/
class LoginScreenModel {
    
    init(monteurCode : String){
        self.monteurCode = monteurCode
    }
    

    var vestiging = "V001"
    var monteurCode = ""
    var code = ""
    
    var pintry = ""
    var pinLabel = ""
    

    /**
    *   @brief Maakt een '.' aan om de pincode the representeren.
    */
    func setLabel(){
        let points = pintry.characters.count
        pinLabel = ""
        if points>0{
            for _ in (0..<points){
                pinLabel += "•"
            }
        }
        else
        {
            pinLabel = " "
        }
    }
    

    /**
    *   @brief Controleert of er 4 cijfers zijn ingevoerd voor de pincode.
    *   @return True als er 4 cijfers zijn ingevoerd voor de pincode
    */
    func pinCompleet() -> Bool
    {
        return (pintry.characters.count == 4)
    }

    /**
    *   @brief zorgt ervoor dat de pincode de goede representatie is om hem te gebruiken.
    *   @return De pincode als een string
    */
    func getPinLabel() -> String
    {
        return pinLabel;
    }

    /**
    *   @brief Controleert of de ingevoerde pincode hetzelfde is als op de server.
    *   @param monteurCode is de ingevoerde pincode door de monteur.
    *   @return True wanneer de pincode overeenkomt met die op de server.
    */
    func pincodeIsCorrect(monteurCode: String) ->	Bool //check of the pincode is consistent with the entered one
    {
        let mainJson: MainJson = MainJson()
        return mainJson.valideerPincodeVoorMonteur(mainJson.getSessieId(), monteurCode: monteurCode, vestiging: vestiging, pincode: pintry)
        
    }
    /**
    *   @brief verwijdert de pincode zodat de gebruiker een nieuwe can invoeren
    */
    func erasePincode(){
        pintry = ""
        setLabel()
    }
    
    /**
    *   @brief Voegt het ingedrukte getal toe aan de huidige pincode
    *   @param pinDigit pincode waarde
    */
    func addDigit(pinDigit: String) {
        pintry = pintry + pinDigit; //add digit to the try
        print("pintry = \(pintry)")
        setLabel()
    }
    
    /**
    *   @brief Verwijdert de laatst ingevoerde waarde van de pincode.
    */
    func deleteDigit(){
        if !pintry.isEmpty{ //delete the last digit
            let indexPinDel = pintry.endIndex.advancedBy(-1)
            pintry = pintry.substringToIndex(indexPinDel)
        }
        setLabel() //update the string represent from the pincode label
    }

}


