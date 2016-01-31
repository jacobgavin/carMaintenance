//
//  instellingenSchermViewController.swift
//  carMaintenance
//
//  Created by vmware on 29/01/16.
//  Copyright © 2016 vmware. All rights reserved.
//

import Foundation
import UIKit

/*!
*   @class InstellingenSchermViewController
*   @brief ViewController van het vestigingskeuze scherm.
*
*   @discussion Deze class is de ViewController van het vestigingskeuze scherm. Het haalt de beschikbare vestigingen op van de server en maakt een lijst met knoppen aan om een vestiging te kiezen.
*
*/

class InstellingenSchermViewController : UIViewController, UITableViewDelegate, UITableViewDataSource
{
    let mj: MainJson = MainJson()
    var vestigingenLijst : Array<BeschikbareVestiging> = Array<BeschikbareVestiging>()
    var geselecteerdeVestiging : BeschikbareVestiging? = BeschikbareVestiging()
    
    @IBOutlet weak var tableView: UITableView!

    /*!
    *   @brief Haalt de lijst van beschikbare vestigingen op en roept de setup voor de layout aan.
    */
    override func viewDidLoad() {
        super.viewDidLoad()
        vestigingenLijst = mj.getBeschikbareVestigingen(mj.getSessieId())
        
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier:"cell")
    }
    /*!
    *   @brief wordt aangeroepen door de app als het geheugen vol raakt
    */
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    /*!
    *   @brief Maakt de losse vestigingsknoppen.
    *   
    *   Wordt aangeroepen door de app zodra het scherm wordt geladen.
    *
    *   @param tableView                De tableView waar de cellen in komen te staan.
    *   @param cellForRowIndexAtPath    De index van de cell die moet worden opgemaakt.
    *   @return                         De cell met de juiste tekst en opmaak.
    */
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        var cell = UITableViewCell()
        
        cell = self.tableView.dequeueReusableCellWithIdentifier("cell")! as UITableViewCell
    
        cell.tag = indexPath.row
        cell.layer.borderWidth = 4
        cell.layer.cornerRadius = 10
        cell.layer.borderColor = UIColor.whiteColor().CGColor
        cell.textLabel?.text = vestigingenLijst[indexPath.row].id+" "+vestigingenLijst[indexPath.row].naam
        cell.textLabel?.textAlignment = NSTextAlignment.Center
        if indexPath.row % 2 == 0
        {
            cell.backgroundColor = UIColor(red: 155/255,green:187/255,blue:89/255, alpha:1.0)
            
        }
        else
        {
            cell.backgroundColor = UIColor(red: 247/255,green:150/255,blue:70/255, alpha:1.0)
        }
            
        return cell
    }
    
    /*!
    *   @brief Geeft het aantal cellen terug dat moet worden gemaakt gebaseerd op het aantal vestigingen.
    *
    *   Wordt aangeroepen door de app als het scherm wordt geladen.
    *
    *   @param tableView                De tableView die de vestigingcellen heeft.
    *   @param numberOfRowsInSection    het huidige aantal rijen.
    *   @return                         het aantal rijen gelijk aan de vestigingen.
    */
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return vestigingenLijst.count
    }
    
    /*!
    *   Slaat de vestiging op in de mainJson.
    *
    *   Wordt aangeroepen door de app als er op een vestiging is geklikt.
    *
    *   @param tableView            de tableView waarin de knoppen staan.
    *   @param didSelectRowAtIndex  de Index van de geselecteerde cel.
    */
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        
        geselecteerdeVestiging  = vestigingenLijst[indexPath.row]
        mj.setVestiging(geselecteerdeVestiging!.id) //sla gekozen vestiging op in de mainJson.
        performSegueWithIdentifier("instellingenSchermNaarMonteurs", sender:nil)
    }
    
    /*!
    *   Geeft de variabelen door aan het volgende scherm.
    *
    *   Wordt aangeroepen door de app als laatste voor het volgende scherm wordt geladen.
    *
    *   Geeft de mainJson door aan de SelecteerPersoonViewController.
    *
    *   @param segue    De verbinding tussen dit scherm en de volgende.
    *   @param sender   De oorzaak van het overgaan naar het volgende scherm.
    */
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        if (segue.identifier == "instellingenSchermNaarMonteurs")
        {
            let lsvc = segue.destinationViewController as! SelecteerPersoonViewController
            lsvc.mainJson = mj
        }
    }
}