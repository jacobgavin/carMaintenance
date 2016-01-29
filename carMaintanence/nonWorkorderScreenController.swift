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
    
    @IBOutlet weak var werkOrderLabel: UILabel!
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
    @IBOutlet weak var backButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        if (werkorder.count == 0){
          
            werkOrderLabel.text = "Nog niet ingeklokt"
        }
        else{
            werkOrderLabel.text = "Ingeklokt op werkorder \(werkorder[0]) (\(werkorder[1]))"
        }
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

