//
//  LoginScreenModel.swift
//  carMaintanence
//
//  Created by vmware on 20/10/15.
//  Copyright © 2015 vmware. All rights reserved.
//

import Foundation
class LoginScreenModel {
    
    init(monteurCode : String){
        self.monteurCode = monteurCode
    }
    
    var monteurCode = ""
    var code = ""
    
    var pintry = ""
    var pinLabel = ""
    
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
    
    func pinCompleet() -> Bool
    {
        return (pintry.characters.count == 4)
    }
    func getPinLabel() -> String //lets the model have the representation of the pincode label
    {
        return pinLabel;
    }
    
    func pincodeIsCorrect(monteurCode: String) ->	Bool //check of the pincode is consistent with the entered one
    {
        let mainJson: MainJson = MainJson()
        return mainJson.valideerPincodeVoorMonteur(mainJson.getSessieId(), monteurCode: monteurCode, vestiging: "V001", pincode: pintry)
        
    }
    
    func erasePincode(){
        pintry = ""
        setLabel()
    }
    
    
    func addDigit(pinDigit: String) {
        pintry = pintry + pinDigit; //add digit to the try
        print("pintry = \(pintry)")
        setLabel() //
    }
    
    func deleteDigit(){
        if !pintry.isEmpty{ //delete the last digit
            let indexPinDel = pintry.endIndex.advancedBy(-1)
            pintry = pintry.substringToIndex(indexPinDel)
        }
        setLabel() //update the string represent from the pincode label
    }

}


