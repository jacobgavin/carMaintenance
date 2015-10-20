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
    @IBOutlet weak var LabelNumber: UILabel!
    
    @IBAction func ButtonClick() {
        labelText += 1;
        LabelNumber.text = "\(labelText)"
    }
    


}

