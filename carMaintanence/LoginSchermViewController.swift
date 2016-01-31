//
//  ViewController.swift
//  carMaintanence
//
//  Created by vmware on 15/10/15.
//  Copyright © 2015 vmware. All rights reserved.
//

import UIKit


/**
    @brief Deze klasse hoort bij het loginscherm en slaat de ingedrukte pincode op om die op te slaan
    voor verifatie
    @TODO: een button maken die ervoor zorgt dat je het laatste getal weer kan verwijderen, functie is er al wel in de loginscreenmodel, moet alleen een button bij die die functie aanroept
*/
class LoginSchermViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        
        _ = NSUserDefaults.standardUserDefaults()
        werknemerNaam.text = monteur.naam
        LogScreen.monteurCode = monteur.code
        // Setup the label for the employee and his pincode
    }
    

    var mainJson:MainJson = MainJson()
    @IBOutlet weak var werknemerNaam: UILabel!
    @IBOutlet weak var pincodeLabel: UILabel!
    
    var monteur: Monteur = Monteur(id: 1, code: "", naam: "")
    
    var labelText = 0;
    var LogScreen = LoginScreenModel(monteurCode: "")

    /**
    @brief Wanneer er op een knop gedrukt geeft zet deze het gedrukte getal in de pincode string.
        Wanneer je 4 cijfers hebt ingevoerd (de pincode lengte) wordt de pincode naar het loginscherm model gestuurd voor verifatie van
        de pincode
    @params de knop waar je op hebt gedrukt
    */
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
    
    /*
        @brief Gaat terug naar het vorige scherm als er gedruktwordt op de knop monteurs
    */
    func goToMonteurs(){
        performSegueWithIdentifier("loginNaarWerkorders", sender: nil)
        }
    
    /*
    *   @brief Geeft de variabelen door aan het volgende scherm.
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
    
    /**
        @brief update de pincode op het scherm
    */
    func updatePincode(){ //update the representation of the pincode
        pincodeLabel.text = LogScreen.getPinLabel()
    }
}

