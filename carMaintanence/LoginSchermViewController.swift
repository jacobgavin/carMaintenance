//
//  ViewController.swift
//  carMaintanence
//
//  Created by vmware on 15/10/15.
//  Copyright © 2015 vmware. All rights reserved.
//

import UIKit

class LoginSchermViewController: UIViewController {
    var monteurID: Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        
        let defaults = NSUserDefaults.standardUserDefaults()
        print(defaults.objectForKey("deviceAppleID") as! String)
        werknemerNaam.text = werknemerLabelTekst
        LogScreen.monteurCode = monteur.code
        monteurID = monteur.id
        // Setup the label for the employee and his pincode
    }
    
    var pincode = ""
    var mainJson:MainJson = MainJson()
    @IBOutlet weak var werknemerNaam: UILabel!
    @IBOutlet weak var pincodeLabel: UILabel!
    
    var monteur: Monteur = Monteur(id: 1, code: "", naam: "")
    
    var labelText = 0;
    var LogScreen = LoginScreenModel(monteurCode: "")
    var werknemerLabelTekst = ""
    var werknemerCode = ""
    @IBAction func buttonClick(sender: UIButton) {
        let digit = sender.currentTitle! //get the value of the pressed number
        LogScreen.addDigit("\(digit)"); //add it to the string of the pin
        updatePincode()
        if LogScreen.pinCompleet(){
            if LogScreen.pincodeIsCorrect(monteur.code){
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
        performSegueWithIdentifier("loginNaarWerkorders", sender: nil)
        }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "loginNaarWerkorders"){
            let woc = segue.destinationViewController as! WerkOrderController
            woc.mainJson = mainJson
            woc.monteurCode = monteur.code
        }
    }
    
    func updatePincode(){ //update the representation of the pincode
        pincodeLabel.text = LogScreen.getPinLabel()
    }
}

