//
//  ViewController.swift
//  carMaintanence
//
//  Created by vmware on 15/10/15.
//  Copyright © 2015 vmware. All rights reserved.
//

import UIKit

class LoginSchermViewController: UIViewController {

    @IBOutlet weak var pincodeLabel: UILabel!
    var labelText = 0;
    var LogScreen = LoginScreenModel(pincode: "1234");
    @IBAction func buttonClick(sender: UIButton) {
        let digit = sender.currentTitle! //get the value of tthe pressed number
        LogScreen.addDigit("\(digit)"); //add it to the string of the pin
        updatePincode()
    }
    
    @IBAction func pressBackspace() {
        LogScreen.deleteDigit() //erase a digit from the pin
        updatePincode()
    }
    
    @IBAction func pressEnter(sender: UIButton) {
        if LogScreen.pincodeIsCorrect(){
            goToMonteurs()
        }
        else{
            pincodeLabel.text = "Wrong pincode"
            LogScreen.erasePincode()
        }
        
    }
    
    func goToMonteurs(){
        performSegueWithIdentifier("Monteurs", sender: nil)
    }
    
    func updatePincode(){ //update the representation of the pincode
        pincodeLabel.text = LogScreen.getPinLabel()
    }
}

