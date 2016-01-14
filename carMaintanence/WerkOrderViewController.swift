	//
//  ViewController.swift
//  CarMaintenance
//
//  Created by vmware on 21/10/15.
//
//

import UIKit

class WerkOrderViewController: UIViewController, UITableViewDelegate,UITableViewDataSource {

    
    var werkorder: Array <Any> = []
    var mainJson: MainJson = MainJson()
    
    var knoppenArray = NSMutableArray()
 
    var aantalKnoppen = 3 //moet uit database komen, het aantal + de data uit een model-klasse halen
    
    //Knop rechtsboven voor wisselen van werkorder
  
    @IBOutlet weak var wisselKnop: UIButton!
    
    @IBAction func wisselKnopIngedrukt(sender: UIButton) {
        print("wisselKnop ingedrukt")
    }
    //view voor nummerbordplaatje
    @IBOutlet weak var nummerbordPlaatje: UIImageView!
    

    //label bovenop het plaatje, geeft tekst van het nummerbord weer
    @IBOutlet weak var nummerBordLabel: UILabel!
    
    // de scrollende tabelview voor de knoppen van de activiteiten
    @IBOutlet weak var tabelView: UITableView!
    
    @IBOutlet weak var tabelViewLinks: UITableView!
    
    @IBOutlet weak var autoLabel: UILabel!
    
    
    @IBOutlet weak var textView: UITextView!
    
    /**
    Vult knoppen met informatie van de taken uit de werkorder
    **/
    func vulKnoppenArray()
    {
        var knop = WerkorderKnop()
        for i in 1...aantalKnoppen
        {
            knop = WerkorderKnop()
            knop.setTitle( "\(i)", forState: UIControlState.Normal);
            knoppenArray.addObject(knop);
            //       print("hallo " + knop.description);
        }
        knop = WerkorderKnop()
        knop.setTitle( "Nieuwe activiteit", forState: UIControlState.Normal);
        knoppenArray.addObject(knop);
        
        for knop in knoppenArray
        {
            print(knop)
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textView.layer.borderWidth = 3
        textView.layer.borderColor = UIColor(red: 128/255, green:100/255, blue:162/255, alpha:1.0).CGColor
        textView.layer.cornerRadius = 10
        
        //tabelView.
        
        wisselKnop.layer.cornerRadius = 5
       // wisselKnop.layer.borderWidth = 1
       // wisselKnop.layer.borderColor = UIColor.whiteColor().CGColor
        
        
        autoLabel.layer.borderWidth = 4
        autoLabel.layer.borderColor = UIColor.whiteColor().CGColor
        autoLabel.layer.cornerRadius = 10
    
        vulKnoppenArray()
        
        //registreert een herbruikbare cell voor de tabelView
        self.tabelView.registerClass(UITableViewCell.self, forCellReuseIdentifier:"cell")
        self.tabelViewLinks.registerClass(UITableViewCell.self, forCellReuseIdentifier:"cell")
        tabelView.sectionHeaderHeight = 10
        
        let myImage = UIImage(named: "nummerbordLeeg.png")
        nummerbordPlaatje.image = myImage
        nummerbordPlaatje.addSubview(nummerBordLabel)
        
        
        tabelView.rowHeight = 120;
       
        // Do any additional setup after loading the view, typically from a nib.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
  
    //aantal rijen in de tableView
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if(tableView == tabelView)
        {
            return knoppenArray.count
        }
        if(tableView == tabelViewLinks)
        {  return 1
        }
        return 0
    }
    

   
    //cellen maken
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell = UITableViewCell()
        
        if(tableView == tabelView)
        {
            cell = self.tabelView.dequeueReusableCellWithIdentifier("cell")! as UITableViewCell
            cell.textLabel?.text = knoppenArray[indexPath.row].description
            cell.tag = indexPath.row
            cell.layer.borderWidth = 4
            cell.layer.cornerRadius = 10
            cell.layer.borderColor = UIColor.whiteColor().CGColor
            
            //cell.layoutMargins = UIEdgeInsetsMake(2000, 2000,  2000,  2000)
        
            if indexPath.row % 2 == 0{
                cell.backgroundColor = UIColor(red: 155/255,green:187/255,blue:89/255, alpha:1.0)
           
            }
            else
            {
                cell.backgroundColor = UIColor(red: 247/255,green:150/255,blue:70/255, alpha:1.0)
            }
        
        
        cell.textLabel?.textAlignment = NSTextAlignment.Center
    //    print(indexPath.row)
        }
        else // dan is het in het werkorder scherm de linker tabel
        {
            cell = self.tabelViewLinks.dequeueReusableCellWithIdentifier("cell")! as UITableViewCell
            cell.textLabel?.text = "Klant wacht!!! "
            cell.tag = indexPath.row
            cell.textLabel?.textColor = UIColor(red:1,green:0,blue:0, alpha:1.0)
            cell.textLabel?.textAlignment = NSTextAlignment.Center
            cell.backgroundColor = UIColor(red: 79/255,green:129/255,blue:189/255, alpha:1.0)
            
       //     let meldingView : UIImageView = UIImageView()
      //      meldingView.image = UIImage(named: "melding.png")
       //     cell.contentView.addSubview(meldingView)
            
            cell.imageView!.image = UIImage(named: "melding.png" )
           
            
        }
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        
        
        print("\(indexPath.row) " + "was geselecteerd")
        if (indexPath.row == aantalKnoppen){
            performSegueWithIdentifier("naarNieuweActiviteit", sender: nil)
        } else {
            performSegueWithIdentifier("naarActiviteit", sender: nil)
        }
        
    }
}
