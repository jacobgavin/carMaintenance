	//
//  ViewController.swift
//  CarMaintenance
//
//  Created by vmware on 21/10/15.
//
//

import UIKit

class WerkOrderViewController: UIViewController, UITableViewDelegate,UITableViewDataSource {

    var huidigeWerkorder: Array<Any> = []
    var werkorder: Array <Any> = [] //doorgeven van welke werkorder geselecteerd is in werkOrderController
    var mainJson: MainJson = MainJson()
    var activiteiten: WerkOrderActiviteit = WerkOrderActiviteit()
    var knoppenArray = NSMutableArray()

    var aantalKnoppen = 3 //moet uit database komen, het aantal + de data uit een model-klasse halen
    
    //Knop rechtsboven voor wisselen van werkorder
  
    @IBOutlet weak var inklokKnop: UIButton!
    
    @IBOutlet weak var uitklokKnop: UIButton!
    
    @IBOutlet weak var werkorderLabel: UILabel!
    
    @IBAction func inklokkenIngedrukt(sender: UIButton) {
        werkorderLabel.backgroundColor = UIColor(red: 33/255, green: 169/255, blue: 6/255, alpha: 1)
        print(terugButton.backgroundColor)
        werkorderLabel.text = "Ingeklokt op werkorder \(werkorder[0]) (\(werkorder[1]))"
        inklokKnop.enabled = false
        inklokKnop.backgroundColor = darkerColorForColor(inklokKnop.backgroundColor!)
        huidigeWerkorder = werkorder
        
        //doe dingen die de backend vertellen dat je bent ingeklokt
        
    }
    //view voor nummerbordplaatje
    @IBOutlet weak var nummerbordPlaatje: UIImageView!
    
    @IBOutlet weak var terugButton: UIButton!

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
        if aantalKnoppen>0
        {
            for i in 1...aantalKnoppen
            {
                knop = WerkorderKnop()
                knop.setTitle( "\(activiteiten.activiteiten[i-1]!.omschrijving)", forState: UIControlState.Normal);
                knoppenArray.addObject(knop);
         //       print("hallo " + knop.description);
            }
        }
        knop = WerkorderKnop()
        knop.setTitle( "Nieuwe activiteit", forState: UIControlState.Normal);
        knoppenArray.addObject(knop);
        
        for knop in knoppenArray
        {
            print(knop)
        }
        
    }
    //Maakt de knoppen rond, en geeft er een witte border aan. Verandert ook kleuren naar of er ingeklokt is. De tekst wordt daar ook op aangepast
    func setLayout() {
        autoLabel.layer.cornerRadius = 10
        autoLabel.layer.borderWidth = 4
        autoLabel.layer.borderColor = UIColor.whiteColor().CGColor
        
        textView.layer.cornerRadius = 10
        textView.layer.borderWidth = 3
        textView.layer.borderColor = UIColor(red: 128/255, green:100/255, blue:162/255, alpha:1.0).CGColor
        
        terugButton.layer.cornerRadius = 10
        terugButton.layer.borderWidth = 4
        terugButton.layer.borderColor = UIColor.whiteColor().CGColor
        
        inklokKnop.layer.cornerRadius = 10
        inklokKnop.layer.borderWidth = 4
        inklokKnop.layer.borderColor = UIColor.whiteColor().CGColor
        
        uitklokKnop.layer.cornerRadius = 10
        uitklokKnop.layer.borderWidth = 4
        uitklokKnop.layer.borderColor = UIColor.whiteColor().CGColor
        
        werkorderLabel.layer.cornerRadius = 10
        werkorderLabel.layer.borderWidth = 4
        werkorderLabel.layer.borderColor = UIColor.whiteColor().CGColor
        werkorderLabel.layer.masksToBounds = true
        if (huidigeWerkorder.count == 0){
            werkorderLabel.text = "Nog niet ingeklokt"
        }
        else{
            if (huidigeWerkorder[0] as! Int == werkorder[0]as! Int){
                werkorderLabel.backgroundColor = UIColor(red: 33/255, green: 169/255, blue: 6/255, alpha: 1)
                print(terugButton.backgroundColor)
                werkorderLabel.text = "Ingeklokt op werkorder \(werkorder[0]) (\(werkorder[1]))"
                inklokKnop.enabled = false
                inklokKnop.backgroundColor = darkerColorForColor(inklokKnop.backgroundColor!)
            }
            werkorderLabel.text = "Ingeklokt op werkorder \(huidigeWerkorder[0]) (\(huidigeWerkorder[1]))"
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setLayout()
        nummerBordLabel.text = (werkorder[1] as! String)
        
        activiteiten = mainJson.getWerkOrderActiviteitenopKenteken(mainJson.getSessieId(), orderNummer: werkorder[0] as! Int)
        aantalKnoppen = activiteiten.activiteiten.count
        autoLabel.text = "WO \(werkorder[0]), \(werkorder[2])"
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
    
    // Voorbereiding op doorgaan naar het volgende scherm. Onder ander de variabelen meegeven.
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "orderNaarOrders1" || segue.identifier == "orderNaarOrders2")
        {
            let lsvc = segue.destinationViewController as! WerkOrderController
            lsvc.mainJson = mainJson
            lsvc.werkorder = huidigeWerkorder}
        if (segue.identifier == "naarNieuweActiviteit"){
            let nac = segue.destinationViewController as! newActivityController
            nac.mainJson = mainJson
            nac.werkorder = werkorder
            nac.huidigeWerkorder = huidigeWerkorder
        }
        if (segue.identifier == "naarActiviteit"){
            let nac = segue.destinationViewController as! actController
            nac.mainJson = mainJson
            nac.werkorder = werkorder
        }
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
        
            if indexPath.row % 2 == 0{
                cell.backgroundColor = UIColor(red: 155/255,green:187/255,blue:89/255, alpha:1.0)
            }
            else
            {
                cell.backgroundColor = UIColor(red: 247/255,green:150/255,blue:70/255, alpha:1.0)
            }
            cell.textLabel?.textAlignment = NSTextAlignment.Center
        }
        else // dan is het in het werkorder scherm de linker tabel
        {
            cell = self.tabelViewLinks.dequeueReusableCellWithIdentifier("cell")! as UITableViewCell
            cell.textLabel?.text = "Klant wacht!!! "
            cell.tag = indexPath.row
            cell.textLabel?.textColor = UIColor(red:1,green:0,blue:0, alpha:1.0)
            cell.textLabel?.textAlignment = NSTextAlignment.Center
            cell.backgroundColor = UIColor(red: 79/255,green:129/255,blue:189/255, alpha:1.0)
            
            cell.imageView!.image = UIImage(named: "melding.png" )
        }
        return cell
    }
    
    //Als er op een knop in de tabel gedrukt wordt, gaat hij naar het volgende scherm.
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("\(indexPath.row) " + "was geselecteerd")
        if (indexPath.row == aantalKnoppen){
            performSegueWithIdentifier("naarNieuweActiviteit", sender: nil)
        } else {
            performSegueWithIdentifier("naarActiviteit", sender: nil)
        }
    }
    
    //Geeft een donkerdere kleur terug.
    func darkerColorForColor(color: UIColor) -> UIColor {
        var r:CGFloat = 0, g:CGFloat = 0, b:CGFloat = 0, a:CGFloat = 0
        if color.getRed(&r, green: &g, blue: &b, alpha: &a){
            return UIColor(red: max(r - 0.2, 0.0), green: max(g - 0.2, 0.0), blue: max(b - 0.2, 0.0), alpha: a)
        }
        return UIColor()
    }
}
