//
//  ActiviteitDummyViewController.swift
//  carMaintenance
//
//  Created by vmware on 09/11/15.
//  Copyright © 2015 vmware. All rights reserved.
//

import UIKit

class ActiviteitDummyViewController: UIViewController {

    
    @IBOutlet weak var werkOrderButton: UIButton!
    @IBOutlet weak var inloggenButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        werkOrderButton.layer.backgroundColor = UIColor(white: 1, alpha: 1).CGColor
        inloggenButton.layer.backgroundColor = UIColor(white: 1, alpha: 1).CGColor
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
