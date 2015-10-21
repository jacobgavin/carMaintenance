//
//  ViewController.swift
//  carMaintanence
//
//  Created by vmware on 15/10/15.
//  Copyright © 2015 vmware. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var labelText = 0;
    var LogScreen = LoginScreenModel();
    @IBAction func buttonClick(sender: UIButton) {
        let digit = sender.currentTitle
        LogScreen.addDigit("\(digit)");
    }
    
    @IBAction func nextButton(sender: UIButton) {
        print("why do I crash? :(")
    }


}

