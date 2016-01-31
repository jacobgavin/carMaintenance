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
        werknemerNaam.text = monteur.naam
        LogScreen.monteurCode = monteur.code
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
    
    /*
    *   Geeft de variabelen door aan het volgende scherm.
    *
    *   Wordt aangeroepen door de app als laatste voor het volgende scherm wordt geladen
    *
    *   Short desciption of what variables are passed
    *
    *   @param segue    De verbinding tussen dit scherm en de volgende
    *   @param sender   De oorzaak van het overgaan naar het volgende scherm
    */
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

