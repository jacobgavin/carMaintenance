//
//  ViewController.swift
//  carMaintanence
//
//  Created by vmware on 15/10/15.
//  Copyright © 2015 vmware. All rights reserved.
//

import UIKit
/*!
*    @class SelecteerPersoonViewController
*    @brief ViewController of the user selection screen.
*    
*    @discussion This class is the ViewController of the user selection screen. It gets all the Monteurs from the server, and displays their names in different tiles.
*
*/
class SelecteerPersoonViewController: UICollectionViewController	 {
    
    
    
    var monteurs: Array<Monteur> = []
    let mainJson : MainJson  = MainJson()
    var Pincodes = ["1111","2345","3456","4567","5678"]
    var appleID = ""
    
    // brief: het opmaken van het scherm en het voorbereiden van de background
    // reason to be called: het scherm wort geladen om op de Ipad te komen
    // Params: none
    // output: none
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainJson.setSessieID()
        monteurs = mainJson.getMonteurs(mainJson.getSessieId())
        
        let defaults = NSUserDefaults.standardUserDefaults()
        if let savedAppleId = defaults.objectForKey("deviceAppleID"){
            appleID = savedAppleId as! String
        }else{
            appleID = (UIDevice.currentDevice().identifierForVendor?.UUIDString)!
            defaults.setObject(appleID, forKey: "deviceAppleID")
        }
        mainJson.setAppleID(appleID)
        mainJson.setSessieID()
        monteurs = mainJson.getMonteurs(mainJson.getSessieId())
    }

    // brief: geheugenmanagement. laat de IPad zelf het management doen
    // reason to be called: geheugen raakt vol
    // Params: none
    // output: none
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // brief: vertelt hoeveel cellen voor monteurs moeten worden gemaakt
    // reason to be called: collectionView wil weten hoeveel cellen moeten worden gemaakt
    // Params: {collectionview, numberofItemsInSection}
    // output: aantal monteurs
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return monteurs.count
    }
    
    // brief: opmaak van een monteurcel
    // reason to be called: collectionView wil weten hoe de cellen eruit moeten zien
    // Params: {collectionView, cellindex voor cell om op te maken}
    // output: de opgemaakte monteurcel
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as UICollectionViewCell
        let Button = cell.viewWithTag(1) as! UILabel
        Button.text = monteurs[indexPath.row].naam
    

        return cell
    }

    // brief: geef de mainJson class en de gekozen monteur door naar het volgende scherm.
    // reason to be called: er wordt op een monteur geklikt.
    // Params: {de segue die is geactiveerd, de monteurButton die is aangeklikt}
    // Return: nothing
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        print("click!")
        if (segue.identifier == "monteursNaarLogin")
        {
            let indexPaths : NSArray = self.collectionView!.indexPathsForSelectedItems()!
            let indexPath : NSIndexPath = indexPaths[0] as! NSIndexPath
            print("\(indexPath.row)")
            let lsvc = segue.destinationViewController as! LoginSchermViewController
            lsvc.monteur = monteurs[indexPath.row]
            lsvc.mainJson = mainJson
            
         
        }
    }

}

