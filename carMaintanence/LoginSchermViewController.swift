//
//  ViewController.swift
//  carMaintanence
//
//  Created by vmware on 15/10/15.
//  Copyright © 2015 vmware. All rights reserved.
//

import UIKit

class LoginSchermViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let defaults = NSUserDefaults.standardUserDefaults()
        print(defaults.objectForKey("deviceAppleID") as! String)
        werknemerNaam.text = werknemerLabelTekst
        LogScreen.pincode = werknemerPincode
        // Setup the label for the employee and his pincode
    }
    
    @IBOutlet weak var werknemerNaam: UILabel!
    @IBOutlet weak var pincodeLabel: UILabel!
    var labelText = 0;
    var LogScreen = LoginScreenModel(pincode: "1234");
    var werknemerLabelTekst = ""
    var werknemerPincode = "1234"
    @IBAction func buttonClick(sender: UIButton) {
        let digit = sender.currentTitle! //get the value of the pressed number
        LogScreen.addDigit("\(digit)"); //add it to the string of the pin
        updatePincode()
        if LogScreen.pinCompleet(){
            if LogScreen.pincodeIsCorrect(){
                goToMonteurs()
            }
            else
            {
                pincodeLabel.text = "Foute code"
                LogScreen.erasePincode()
            }
        }
    }
    
    func goToMonteurs(){
        print("laden gegevens van \(werknemerLabelTekst)")
        performSegueWithIdentifier("loginNaarWerkorders", sender: nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "loginNaarWerkorders"){
//            let wovc = segue.destinationViewController as! WorkOrderViewController
//            wovc.werknemer = werknemerLabelTekst
        }
    }
    
    func updatePincode(){ //update the representation of the pincode
        pincodeLabel.text = LogScreen.getPinLabel()
    }
}

