//
//  WorkorderControllerViewController.swift
//  carMaintanence
//
//  Created by vmware on 29/10/15.
//  Copyright © 2015 vmware. All rights reserved.
//

import UIKit

class WorkOrderViewController: UIViewController {
    
    var werknemer = ""
    var mijnWerkorder = true;
    @IBOutlet weak var segmentWerkOrders: UISegmentedControl!
    @IBOutlet weak var collectionWerkOrders: UICollectionView!
    @IBOutlet weak var labelWerkOrder: UILabel!
    
    @IBAction func uitklokButton(sender: AnyObject) {
        // Uitklokken
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionWerkOrders.backgroundColor = UIColor.whiteColor()
        labelWerkOrder.text = "Ingeklokt op werkorder 53-NPW-WZ Ford Focus Turbo"

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func segmentWerkOrderAction(sender: UISegmentedControl) {
        if (segmentWerkOrders.selectedSegmentIndex == 0) {
            mijnWerkorder = true
        } else if (segmentWerkOrders.selectedSegmentIndex == 1) {
            mijnWerkorder = false
        }
        updateCollectionWerkOrders()
    }
    
    func updateCollectionWerkOrders() {
        // update the collection view when there is
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
