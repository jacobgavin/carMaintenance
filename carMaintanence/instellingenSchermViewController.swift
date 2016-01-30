//
//  instellingenSchermViewController.swift
//  carMaintenance
//
//  Created by vmware on 29/01/16.
//  Copyright © 2016 vmware. All rights reserved.
//

import Foundation
import UIKit

class InstellingenSchermViewController : UIViewController, UITableViewDelegate, UITableViewDataSource
{
    let mj: MainJson = MainJson()
    var vestigingenLijst : Array<BeschikbareVestiging> = Array<BeschikbareVestiging>()
    var geselecteerdeVestiging : BeschikbareVestiging? = BeschikbareVestiging()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /*
            Moet nog via seque een mainjson of sessieId krijgen ipv deze
        */
        vestigingenLijst = mj.getBeschikbareVestigingen(mj.getSessieId())
        
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier:"cell")
        //self.tableView.backgroundColor = UIColor(CGColor: <#T##CGColor#>)
    }
    @IBOutlet weak var tableView: UITableView!
    
    
    
        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
        }

    
    
        func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
        {
            
            var cell = UITableViewCell()
            
                cell = self.tableView.dequeueReusableCellWithIdentifier("cell")! as UITableViewCell
            

                cell.tag = indexPath.row
                cell.layer.borderWidth = 4
                cell.layer.cornerRadius = 10
                cell.layer.borderColor = UIColor.whiteColor().CGColor
                cell.textLabel?.text = vestigingenLijst[indexPath.row].id+" "+vestigingenLijst[indexPath.row].naam
            
            
                if indexPath.row % 2 == 0
                {
                    cell.backgroundColor = UIColor(red: 155/255,green:187/255,blue:89/255, alpha:1.0)
                    
                }
                else
                {
                    cell.backgroundColor = UIColor(red: 247/255,green:150/255,blue:70/255, alpha:1.0)
                }
                
                
                cell.textLabel?.textAlignment = NSTextAlignment.Center
                //    print(indexPath.row)
            
            return cell
        }

        func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
        {
            
             geselecteerdeVestiging  = vestigingenLijst[indexPath.row]
            mj.setVestiging(geselecteerdeVestiging!.id)
            performSegueWithIdentifier("instellingenSchermNaarMonteurs", sender:nil)
            print(geselecteerdeVestiging!.naam)
        }

        func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
        {
            return vestigingenLijst.count
        }
    
    
        
        override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
        {
            print("click!")
            if (segue.identifier == "instellingenSchermNaarMonteurs")
            {
                let lsvc = segue.destinationViewController as! SelecteerPersoonViewController
                lsvc.mainJson = mj
                    //.vestiging = geselecteerdeVestiging!.id
                print(geselecteerdeVestiging!.id)
            }
        }




}