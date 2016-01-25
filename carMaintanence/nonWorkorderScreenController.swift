//
//  ViewController.swift
//  CarmaintananceNonworkingScreeen
//
//  Created by vmware on 29/10/15.
//  Copyright © 2015 Carmaintanceapp. All rights reserved.
//

import UIKit

class nonWorkorderScreenController: UIViewController {

    var vorigeScherm = ""
    @IBAction func Back(sender: UIButton) {
        if(vorigeScherm=="ac"){
            performSegueWithIdentifier("nwNaarAc", sender: nil)
        }
        else{
            performSegueWithIdentifier("nwNaarWo", sender: nil)
        }
    }
    @IBOutlet weak var backButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        print(vorigeScherm)
        print("hoi\n")
        if(vorigeScherm=="ac"){
            backButton.setTitle("Terug naar activiteiten", forState: .Normal)
        }
        else{
            backButton.setTitle("Terug naar werkorder", forState: .Normal)
        }
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

