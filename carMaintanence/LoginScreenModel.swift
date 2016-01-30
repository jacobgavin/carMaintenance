//
//  LoginScreenModel.swift
//  carMaintanence
//
//  Created by vmware on 20/10/15.
//  Copyright © 2015 vmware. All rights reserved.
//

import Foundation

/*!
    *   @class LoginScreenModel
    *   @brief Model (logic) for the login screen.
    *   @warning TODO: Un-hardcode the vestiging so it can be modified in settings. Currently only works on V001

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
    

    /*!
    *   @brief Sets a 'dot' to represent an entered pin-code.
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
    

    /*!
    *   @brief Checks if 4 pin-characters are pushed.
    *   @return True if 4 pin-characters are entered
    */
    func pinCompleet() -> Bool
    {
        return (pintry.characters.count == 4)
    }

    /*!
    *   @brief Lets the model have the representation of the pincode.
    *   @return returns the label
    */
    func getPinLabel() -> String
    {
        return pinLabel;
    }

    /*!
    *   @brief Checks the local pincode that has been entered with the correct pincode that is on the server.
    *   @param monteurCode Entered pincode of the monteur .
    *   @return True when the monteurCode matches.
    */
    func pincodeIsCorrect(monteurCode: String) ->	Bool //check of the pincode is consistent with the entered one
    {
        let mainJson: MainJson = MainJson()
        return mainJson.valideerPincodeVoorMonteur(mainJson.getSessieId(), monteurCode: monteurCode, vestiging: vestiging, pincode: pintry)
        
    }
    /*!
    *   @brief Empties the pin label so the user can enter it again
    */
    func erasePincode(){
        pintry = ""
        setLabel()
    }
    
    /*!
    *   @brief Adds the entered digit to the current pinlist
    *   @param pinDigit pincode value
    */
    func addDigit(pinDigit: String) {
        pintry = pintry + pinDigit; //add digit to the try
        print("pintry = \(pintry)")
        setLabel()
    }
    
    /*!
    *   @brief Deletes the last entered digit from the current pinlist.
    */
    func deleteDigit(){
        if !pintry.isEmpty{ //delete the last digit
            let indexPinDel = pintry.endIndex.advancedBy(-1)
            pintry = pintry.substringToIndex(indexPinDel)
        }
        setLabel() //update the string represent from the pincode label
    }

}


