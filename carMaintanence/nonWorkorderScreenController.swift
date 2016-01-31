//
//  ViewController.swift
//  CarmaintananceNonworkingScreeen
//
//  Created by vmware on 29/10/15.
//  Copyright © 2015 Carmaintanceapp. All rights reserved.
//

import UIKit

/*!
    @Class nonWorkOrderSreeController
    @brief deze klasse gaat over de improductieve uren
    @discussion deze klasse zorgt ervoor dat je improductieve uren kan klokken en maakt het scherm erbij
    @TODO verbinden met de mainjson als er in de api improductieve uren geklokt kunnen worden, deze klasse doet verder nog niet veel
*/
class nonWorkorderScreenController: UIViewController {
    var mainJson: MainJson = MainJson()
    
    @IBOutlet weak var werkOrderLabel: UILabel!
    var werkorder: Array <Any> = []
    var huidigeWerkorder: Array<Any> = []
    var vorigeScherm = ""

    @IBOutlet weak var backButton: UIButton!

    @IBOutlet weak var Pauzebutton: UIButton!
    
    @IBOutlet weak var geenWerkButton: UIButton!
    
    @IBOutlet weak var halenButton: UIButton!
    
    @IBOutlet weak var vegenbutton: UIButton!
    
    /*!
        @brief maakt de layout voor het scherm
        @output ronde knoppen met een witte rand waar nodig
    */
    func setLayout(){
        let myWidth : CGFloat = 4
        let myRadius : CGFloat = 10
        let myColor : UIColor = UIColor.whiteColor()
        
        backButton.layer.cornerRadius = myRadius
        backButton.layer.borderWidth = myWidth
        backButton.layer.borderColor = myColor.CGColor
        
        Pauzebutton.layer.cornerRadius = myRadius
        Pauzebutton.layer.borderWidth = myWidth
        Pauzebutton.layer.borderColor = myColor.CGColor
        
        vegenbutton.layer.cornerRadius = myRadius
        vegenbutton.layer.borderWidth = myWidth
        vegenbutton.layer.borderColor = myColor.CGColor
        
        geenWerkButton.layer.cornerRadius = myRadius
        geenWerkButton.layer.borderWidth = myWidth
        geenWerkButton.layer.borderColor = myColor.CGColor
        
        werkOrderLabel.layer.cornerRadius = myRadius
        werkOrderLabel.layer.borderWidth = myWidth
        werkOrderLabel.layer.borderColor = myColor.CGColor
        
        halenButton.layer.cornerRadius = myRadius
        halenButton.layer.borderWidth = myWidth
        halenButton.layer.borderColor = myColor.CGColor
        
        if (huidigeWerkorder.count == 0){
            werkOrderLabel.text = "Nog niet ingeklokt"
        } else{
            werkOrderLabel.text = "Ingeklokt op werkorder \(huidigeWerkorder[0]) (\(huidigeWerkorder[1]))"
            if (huidigeWerkorder[0] as! Int == werkorder[0]as! Int)
            {
                werkOrderLabel.backgroundColor = UIColor(red: 33/255, green: 169/255, blue: 6/255, alpha: 1)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setLayout()
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
        if (segue.identifier == "nonWorkToAct")
        {
            let ac = segue.destinationViewController as! actController
            ac.mainJson = mainJson
            ac.werkorder = werkorder
            ac.huidigeWerkorder = huidigeWerkorder
        }
        if (segue.identifier == "nonWorkNaarOrders")
        {
            let ac = segue.destinationViewController as! WerkOrderController
            ac.mainJson = mainJson
            ac.werkorder = werkorder
        }
    }
    /*!
        @brief: geheugenmanagement. laat de IPad zelf het management doen
        @reason to be called: geheugen raakt vol
        @Params: none
        @output: none
    */
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}