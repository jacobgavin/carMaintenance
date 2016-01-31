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
    var mainJson : MainJson  = MainJson()
    var Pincodes = ["1111","2345","3456","4567","5678"]
    var appleID = ""
    
    /**
    *   Haalt de lijst van monteurs op.
    */
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
//        mainJson.setSessieID()
//        monteurs = mainJson.getMonteurs(mainJson.getSessieId())
    }

    /**
    *   wordt aangeroepen door de app als het geheugen vol raakt
    */
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /**
    *   Vertelt hoeveel cellen voor monteurs moeten worden gemaakt.
    * 
    *   Wordt aangeroepen door de app als het scherm wordt geladen.
    *
    *   @param collectionview           De collectionView waar de monteurs in komen
    *   @param numberofItemsInSection   Het standaard aantal cellen.
    *   @return                         Het aantal cellen, gebaseerd op het aantal monteurs, dat in de collectionview moet komen.
    */
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return monteurs.count
    }
    
    /**
    *   opmaak van een monteurcel.
    *
    *   Wordt aangeroepen door de app als het scherm wordt geladen.
    *
    *   Maakt voor elke cell een button en een label met de naam van de monteur.
    *
    *   TODO: als er foto's komen voor de monteurs moet je die hier instellen
    *
    *   @Param collectionView           de collectionView waar de monteurs in komen te staan
    *   @param cellForItemAtPathIndex   Index van de op te maken cel
    *   @return                         de opgemaakte monteurcel
    */
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as UICollectionViewCell
        let Button = cell.viewWithTag(1) as! UILabel
        Button.text = monteurs[indexPath.row].naam
    
        return cell
    }

    /*
    *   Geeft de variabelen door aan het volgende scherm.
    *
    *   Wordt aangeroepen door de app als laatste voor het volgende scherm wordt geladen
    *
    *   Geeft de gekozen monteur en de mainJson door aan de LoginSchermViewController
    *
    *   @param segue    De verbinding tussen dit scherm en de volgende
    *   @param sender   De oorzaak van het overgaan naar het volgende scherm
    */
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

