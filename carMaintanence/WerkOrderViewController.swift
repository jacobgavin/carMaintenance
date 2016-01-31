	//
//  ViewController.swift
//  CarMaintenance
//
//  Created by vmware on 21/10/15.
//
//

import UIKit
    
/*!
    @class WerkOrderViewController
    @brief Klasse laat de activiteiten zien die bij een geselecteerde workorder hoort
    @discussion Deze klasse krijgt een werkorder van het vorige scherm en laat van deze werkorder de juiste activiteiten zien
*/

class WerkOrderViewController: UIViewController, UITableViewDelegate,UITableViewDataSource {

    var huidigeWerkorder: Array<Any> = []
    var werkorder: Array <Any> = [] //doorgeven van welke werkorder geselecteerd is in werkOrderController
    var mainJson: MainJson = MainJson()
    var activiteiten: WerkOrderActiviteit = WerkOrderActiviteit()
    var knoppenArray = NSMutableArray()
    var monteurCode: String = ""

    var aantalKnoppen = 3 //moet uit database komen, het aantal + de data uit een model-klasse halen
    
    //Knop rechtsboven voor wisselen van werkorder
  
    @IBOutlet weak var inklokKnop: UIButton!
    
    @IBOutlet weak var uitklokKnop: UIButton!
    
    @IBOutlet weak var werkorderLabel: UILabel!
    
    @IBOutlet weak var nummerbordPlaatje: UIImageView!
    
    @IBOutlet weak var terugButton: UIButton!
    
    @IBOutlet weak var nummerBordLabel: UILabel!
    
    @IBOutlet weak var tabelView: UITableView!
    
    @IBOutlet weak var tabelViewLinks: UITableView!
    
    @IBOutlet weak var autoLabel: UILabel!
    
    @IBOutlet weak var textView: UITextView!
    
    /*!
        @brief Verandert the kleur van de inklokken button en de kleur van de werkorderlabel. Als je inklokken indrukt kun je hem niet meer opnieuw indrukken
        @params sender is de inklokken knop
        TODO: Api van inklokken ontbrak nog. Deze functie heb je hier nodig om in te klokken.
    */
    
    @IBAction func inklokkenIngedrukt(sender: UIButton) {
        werkorderLabel.backgroundColor = UIColor(red: 33/255, green: 169/255, blue: 6/255, alpha: 1)
        print(terugButton.backgroundColor)
        werkorderLabel.text = "Ingeklokt op werkorder \(werkorder[0]) (\(werkorder[1]))"
        inklokKnop.enabled = false
        inklokKnop.backgroundColor = darkerColorForColor(inklokKnop.backgroundColor!)
        huidigeWerkorder = werkorder
    }

    
    /*!
        @brief Vult knoppen de knoppen met de informatie uit de werkorder
    */
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
            }
        }
        knop = WerkorderKnop()
        knop.setTitle( "Nieuwe activiteit", forState: UIControlState.Normal);
        knoppenArray.addObject(knop);
    }
    
    /*!
        @brief Maakt de knoppen rond, en geeft er een witte border aan. Verandert ook kleuren naar of er ingeklokt is. De tekst wordt daar ook op aangepast
    */
    func setLayout() {
        let myColor : UIColor = UIColor.whiteColor()
        let purpleColor : UIColor = UIColor.purpleColor()
        let myWidth : CGFloat = 4
        let myRadius : CGFloat = 10
        
        autoLabel.layer.cornerRadius = myRadius
        autoLabel.layer.borderWidth = myWidth
        autoLabel.layer.borderColor = myColor.CGColor
        
        textView.layer.cornerRadius = myRadius
        textView.layer.borderWidth = 3
        textView.layer.borderColor = purpleColor.CGColor
        
        terugButton.layer.cornerRadius = myRadius
        terugButton.layer.borderWidth = myWidth
        terugButton.layer.borderColor = myColor.CGColor
        
        inklokKnop.layer.cornerRadius = myRadius
        inklokKnop.layer.borderWidth = myWidth
        inklokKnop.layer.borderColor = myColor.CGColor
        
        uitklokKnop.layer.cornerRadius = myRadius
        uitklokKnop.layer.borderWidth = myWidth
        uitklokKnop.layer.borderColor = myColor.CGColor
        
        werkorderLabel.layer.cornerRadius = myRadius
        werkorderLabel.layer.borderWidth = myWidth
        werkorderLabel.layer.borderColor = myColor.CGColor
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
        
        //geeft het juiste kenteken op het kenteken bord
        nummerBordLabel.text = (werkorder[1] as! String)
        
        //Maakt de juiste hoeveelheid knoppen aan
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
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
  
    /*!
        @brief geeft het aantal rijen wat je nodig hebt in de table view
        @return het aantal rijen in de tableview
        @params tableview is de tableview waar de activiteiten inkomen
                numbersOfRowsInSection is het aantal rijen
    */
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
    
    /*!
    *   @brief Geeft de variabelen door aan het volgende scherm.
    *
    *   Wordt aangeroepen door de app als laatste voor het volgende scherm wordt geladen
    *
    *   Short desciption of what variables are passed
    *
    *   @param segue    De verbinding tussen dit scherm en de volgende
    *   @param sender   De oorzaak van het overgaan naar het volgende scherm
    */
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "orderNaarOrders1" || segue.identifier == "orderNaarOrders2")
        {
            let lsvc = segue.destinationViewController as! WerkOrderController
            lsvc.mainJson = mainJson
            lsvc.werkorder = huidigeWerkorder
            lsvc.monteurCode = monteurCode
            
        }
        if (segue.identifier == "naarNieuweActiviteit"){
            let nac = segue.destinationViewController as! newActivityController
            nac.mainJson = mainJson
            nac.werkorder = werkorder
            nac.huidigeWerkorder = huidigeWerkorder
            // lsvc.monteurID = monteurID // implement in newActivityController
        }
        if (segue.identifier == "naarActiviteit"){
            let nac = segue.destinationViewController as! actController
            nac.mainJson = mainJson
            nac.werkorder = werkorder
            nac.huidigeWerkorder = huidigeWerkorder
            // lsvc.monteurID = monteurID // implement in actController
        }
    }
    

   /*!
        @brief cellen maken die goed opgevuld worden met de activiteiten die op de server staan
        @params tableview is de tabelmet activiteiten
                cellForRowAtIndexPath is de rij waar een activiteit komt te staan
        @return de tabel met een toegevoegde rij met een activiteit
    */
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
    
    /*!
        @brief Als er op een knop in de tabel gedrukt wordt, gaat hij naar het volgende scherm.
        @params tableview is de tabel waar je op een knop hebt gedrukt
                didSelectRowAtIndexPath is de rij die je hebt aangeklikt
    */
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if (indexPath.row == aantalKnoppen){
            performSegueWithIdentifier("naarNieuweActiviteit", sender: nil)
        } else {
            performSegueWithIdentifier("naarActiviteit", sender: nil)
        }
    }
    
    /*!
        @brief Geeft een donkerdere kleur terug.
    */
    func darkerColorForColor(color: UIColor) -> UIColor {
        var r:CGFloat = 0, g:CGFloat = 0, b:CGFloat = 0, a:CGFloat = 0
        if color.getRed(&r, green: &g, blue: &b, alpha: &a){
            return UIColor(red: max(r - 0.2, 0.0), green: max(g - 0.2, 0.0), blue: max(b - 0.2, 0.0), alpha: a)
        }
        return UIColor()
    }
}
