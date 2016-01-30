//
//  ViewController.swift
//  CarmaintananceNonworkingScreeen
//
//  Created by vmware on 29/10/15.
//  Copyright © 2015 Carmaintanceapp. All rights reserved.
//

import UIKit

class nonWorkorderScreenController: UIViewController {
    var mainJson: MainJson = MainJson()
    
    @IBOutlet weak var Pauzebutton: UIButton!
    
    @IBOutlet weak var geenWerkButton: UIButton!
    
    @IBOutlet weak var halenButton: UIButton!
    
    @IBOutlet weak var vegenbutton: UIButton!
    
    @IBOutlet weak var werkOrderLabel: UILabel!
    
    @IBOutlet weak var backButton: UIButton!
    
    var werkorder: Array <Any> = []
    var vorigeScherm = ""
//    @IBAction func Back(sender: UIButton) {
//        if(vorigeScherm=="ac"){
//            performSegueWithIdentifier("nwNaarAc", sender: nil)
//        }
//        else{
//            performSegueWithIdentifier("nwNaarWo", sender: nil)
//        }
//    }

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
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if (werkorder.count == 0){
          
            werkOrderLabel.text = "Nog niet ingeklokt"
        }
        else{
            werkOrderLabel.text = "Ingeklokt op werkorder \(werkorder[0]) (\(werkorder[1]))"
        }
        setLayout()
        
//        print(vorigeScherm)
//        print("hoi\n")
//        if(vorigeScherm=="ac"){
//            backButton.setTitle("Terug naar activiteiten", forState: .Normal)
//        }
//        else{
//            backButton.setTitle("Terug naar werkorder", forState: .Normal)
//        }
//        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "nonWorkToAct")
        {
            let ac = segue.destinationViewController as! actController
            ac.mainJson = mainJson
            ac.werkorder = werkorder
                       
        }
        if (segue.identifier == "nonWorkNaarOrders")
        {
            let ac = segue.destinationViewController as! WerkOrderController
            ac.mainJson = mainJson
            ac.werkorder = werkorder
            
        }
    }

    // brief: geheugenmanagement. laat de IPad zelf het management doen
    // reason to be called: geheugen raakt vol
    // Params: none
    // output: none
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

