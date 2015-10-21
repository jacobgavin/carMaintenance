//
//  LoginScreenModel.swift
//  carMaintanence
//
//  Created by vmware on 20/10/15.
//  Copyright © 2015 vmware. All rights reserved.
//

import Foundation
class LoginScreenModel {
    init(pincode: String){
        self.pincode = pincode
    }
    var pincode = "";
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
    }
    
    func getPinLabel() -> String //lets the model have the representation of the pincode label
    {
        return pinLabel;
    }
    
    func pincodeIsCorrect() ->	Bool //check of the pincode is consistent with the entered one
    {
        return pincode == pintry;
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


