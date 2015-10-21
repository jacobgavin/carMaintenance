//
//  ViewController.swift
//  carMaintanence
//
//  Created by vmware on 15/10/15.
//  Copyright © 2015 vmware. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var pincodeLabel: UILabel!
    var labelText = 0;
    var LogScreen = LoginScreenModel();
    @IBAction func buttonClick(sender: UIButton) {
        let digit = sender.currentTitle!
        LogScreen.addDigit("\(digit)");
        pincodeLabel.text = LogScreen.getPinLabel()
    }
}

