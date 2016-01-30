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
    var huidigeWerkorder: Array<Any> = []
    var vorigeScherm = ""

    @IBOutlet weak var backButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        if (huidigeWerkorder.count == 0){
          
            werkOrderLabel.text = "Nog niet ingeklokt"
        }
        else{
            werkOrderLabel.text = "Ingeklokt op werkorder \(huidigeWerkorder[0]) (\(huidigeWerkorder[1]))"
            werkOrderLabel.backgroundColor = UIColor(red: 33/255, green: 169/255, blue: 6/255, alpha: 1)
        }
    }
    
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

    // brief: geheugenmanagement. laat de IPad zelf het management doen
    // reason to be called: geheugen raakt vol
    // Params: none
    // output: none
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

