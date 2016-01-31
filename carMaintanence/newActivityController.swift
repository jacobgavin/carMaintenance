//
//  newActivityController.swift
//  carMaintenance
//
//  Created by vmware on 29/10/15.
//  Copyright © 2015 vmware. All rights reserved.
//

import UIKit

/*
    @Class newActivityController
    @brief Laat een monteur een nieuwe activiteit aanmaken, je hebt alleen de omschrijving en de titel nodig
    TODO: In de api heb je geen titel nodig, dit is wel nodig volgens het strybord en moet dus nog aan de api toegevoegd worden
*/
class newActivityController: UIViewController {
    var regNum = ""
    var workOrder = ""
    var mainJson: MainJson = MainJson()
    var werkorder: Array<Any> = []
    var huidigeWerkorder: Array<Any> = []
    let placeholder_text = "Omschrijving van Activiteit"
    
    @IBOutlet weak var logOutButton: UIButton!
    
    @IBOutlet weak var loggedInOnWorkOrder: UILabel!
    
    @IBOutlet weak var regNumberOfCar: UITextField!
    
    @IBOutlet weak var workNumAndCarModel: UITextField!
    
    @IBOutlet weak var descTextField: UITextView! // the Editable textfield
    
    @IBOutlet weak var titleOfNewActivity: UITextField!
    
    @IBOutlet weak var newActivityButton: UIButton!
    
    @IBOutlet weak var cameraButton: UIButton!
    
    @IBOutlet weak var editButton: UIButton!
    
    @IBAction func saveButton(sender: UIButton) {
        let title = titleOfNewActivity.text!
        let description = descTextField.text!
        print(title)
        print(description)
        mainJson.opslaanActiviteit("VR-786-L", sessieId: mainJson.getSessieId(), omschrijving: "lslkfjlskdjflksjfd",id: 42, code: "codeiets")
    }
    
    /**
        @brief Maakt de layout voor het scherm met ronde knoppen en witte randen
    */
    func setLayout(){
        let myColor : UIColor = UIColor.whiteColor()
        let purpleColor : UIColor = UIColor.purpleColor()
        let myWidth : CGFloat = 4
        let myRadius : CGFloat = 10
        
        
        titleOfNewActivity.layer.borderColor = myColor.CGColor
        
        workNumAndCarModel.layer.borderColor = myColor.CGColor
        workNumAndCarModel.layer.borderWidth = myWidth
        workNumAndCarModel.layer.cornerRadius = myRadius
        
        newActivityButton.layer.borderColor = myColor.CGColor
        newActivityButton.layer.borderWidth = myWidth
        newActivityButton.layer.cornerRadius = myRadius
        
        cameraButton.layer.borderColor = myColor.CGColor
        cameraButton.layer.borderWidth = myWidth
        cameraButton.layer.cornerRadius = myRadius
        
        editButton.layer.borderColor = myColor.CGColor
        editButton.layer.borderWidth = myWidth
        editButton.layer.cornerRadius = myRadius
        
        
        loggedInOnWorkOrder.layer.cornerRadius = myRadius
        loggedInOnWorkOrder.text = "Aanpassen voor werkorder \(werkorder[0]) (\(werkorder[1]))"
        loggedInOnWorkOrder.layer.borderColor = myColor.CGColor
        loggedInOnWorkOrder.layer.borderWidth = myWidth
        loggedInOnWorkOrder.layer.masksToBounds = true
        
        logOutButton.layer.cornerRadius = myRadius
        logOutButton.layer.borderWidth = myWidth
        logOutButton.layer.cornerRadius = myRadius
        logOutButton.layer.borderColor = myColor.CGColor
        
        descTextField.layer.borderColor = purpleColor.CGColor
        descTextField.layer.borderWidth = myWidth
        descTextField.layer.cornerRadius = myRadius
        descTextField.text = ""

        regNumberOfCar.text = (werkorder[1] as! String)
        regNumberOfCar.userInteractionEnabled = false

        workNumAndCarModel.userInteractionEnabled = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLayout()  
    }
    
    /**
        @brief als je een omschrijving gaat invoeren verwijdert deze functie de standaard tekst
    */
    func textViewDidBeginEditing(textview: UITextView){
        if (textview.text == "Omschrijving van de Activiteit"){
            textview.text = nil        
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    /**
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
        if(segue.identifier == "nieuweActiviteitNaarWerkorder"){
            let wovc = segue.destinationViewController as! WerkOrderViewController
            wovc.mainJson = mainJson
            wovc.werkorder = werkorder
            wovc.huidigeWerkorder = huidigeWerkorder
        }
    }
}