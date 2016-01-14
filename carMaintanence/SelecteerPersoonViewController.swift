//
//  ViewController.swift
//  carMaintanence
//
//  Created by vmware on 15/10/15.
//  Copyright © 2015 vmware. All rights reserved.
//

import UIKit

class SelecteerPersoonViewController: UICollectionViewController	 {
    
    
    
    var monteurs: Array<Monteur> = []
    
    
    
    
    var Pincodes = ["1111","2345","3456","4567","5678"]
    var appleID = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        let mainJson : MainJson  = MainJson()
        
        
        monteurs = mainJson.getMonteurs(mainJson.getSessieId())
        
        
        let defaults = NSUserDefaults.standardUserDefaults()
        if let savedAppleId = defaults.objectForKey("deviceAppleID"){
            appleID = savedAppleId as! String
        }else{
            appleID = (UIDevice.currentDevice().identifierForVendor?.UUIDString)!
            defaults.setObject(appleID, forKey: "deviceAppleID")
        }
        //print(appleID)
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return monteurs.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as UICollectionViewCell
        
        let Button = cell.viewWithTag(1) as! UILabel
        Button.text = monteurs[indexPath.row].naam
    

        return cell
    }
//    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath){
//            print("select")
//            self.performSegueWithIdentifier("monteursNaarLogin", sender: self)
//    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        print("click!")
        if (segue.identifier == "monteursNaarLogin")
        {
            let indexPaths : NSArray = self.collectionView!.indexPathsForSelectedItems()!
            let indexPath : NSIndexPath = indexPaths[0] as! NSIndexPath
            print("\(indexPath.row)")
            let lsvc = segue.destinationViewController as! LoginSchermViewController
            lsvc.monteur = monteurs[indexPath.row]
            
         
        }
    }
// test

}

