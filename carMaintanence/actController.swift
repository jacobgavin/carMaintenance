
//
//  activityController.swift
//  carMaintenance
//
//  Created by vmware on 05/11/15.
//  Copyright © 2015 vmware. All rights reserved.
//

import UIKit
/*!
    @brief deze klasse maakt de table view van de activiteiten
*/
class TableActivity: UITableViewCell {
    var exist: Bool = false
    var column1: String = ""
    var column2: String = ""
    var column3: String = ""
    var newLabel1: UILabel!
    var newLabel2: UILabel!
    var newLabel3: UILabel!
    var width: CGFloat = 0.0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.width = self.layer.bounds.width
        for view in self.subviews {
            view.removeFromSuperview()
        }
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    /*!
        @brief maakt het juiste aantal kolommen van de goede grootte
        @params col is het aantal kolommen nodig in totaal
                string vult de initiele tableview met lege tekst, dit wordt later geupdate in de code
    */
    func setValueForColumn(string: String, col:Int) {
        let cellWidth = self.layer.bounds.width
        
        if (col==1) {
            newLabel1 = UILabel(frame: CGRectMake(0, 0.0, cellWidth/4.0, 30.0))
            newLabel1.numberOfLines = 0
            newLabel1.text = string
            exist = true
            self.contentView.addSubview(newLabel1)
        }
        if (col==2) {
            newLabel2 = UILabel(frame: CGRectMake(cellWidth/4.0, 0.0, cellWidth/8.0, 30.0))
            newLabel2.numberOfLines = 0
            newLabel2.text = string
            exist = true
            self.contentView.addSubview(newLabel2)
            
        }
        if (col==3) {
            newLabel3 = UILabel(frame: CGRectMake(cellWidth/4.0+cellWidth/8.0, 0.0, 3*cellWidth/8.0, 30.0))
            newLabel3.numberOfLines = 0
            newLabel3.text = string
            exist = true
            self.contentView.addSubview(newLabel3)
        }
        
    }
    
    func getWidth() -> CGFloat
    {
        return self.width
    }

    
}

/*!
    @brief deze klasse zorgt voor de rest van de indeling van de view en zorgt ervoor dat alle knoppen werken
*/
class actController: UIViewController, UITableViewDelegate, UITableViewDataSource  {
    var workOrder: Int = 0
    var carModel: String = ""
    var titleActivity: String = ""
    var license: String = ""
    
    @IBOutlet weak var carLicenceNum: UITextField!
    @IBOutlet weak var workAndCarModel: UITextField!  
    @IBOutlet weak var titleOfActivity: UITextField!
    @IBOutlet weak var loggedInAtLabel: UILabel!    
    @IBOutlet weak var terugButton: UIButton!    
    @IBOutlet weak var imprurenButton: UIButton!  
    @IBOutlet weak var internBerichtView: UITextView! 
    @IBOutlet weak var backButton: UIButton!  // not implemented
    @IBOutlet weak var tableViewContainer: UITableView!
    @IBOutlet weak var headerForLabels: UICustomView!
    
    var cellWidth: CGFloat = 0.0
    

    // json information
    var huidigeWerkorder: Array<Any> = []
    var werkorder: Array <Any> = [] //doorgeven van welke werkorder geselecteerd is in werkOrderController
    var activities: WerkOrderActiviteit = WerkOrderActiviteit()
    var mainJson: MainJson = MainJson()
    var sessionID: String = ""
    // This array is populated with data and every nested array is one row containing
    // 3 different strings
    var tableData = [["Verrichting 1",0.5,"APK met viergastest"],["Onderd. 1",1,"Sticker 'APK zonder afspraak'"],[3.1,3.2,3.3]] // illustration only
  
    /*!
        @brief maakt de layout voor de hele view dat alles ronde hoeken heeft en waar nodig witte randen
    */
    func setLayout(){
        let myColor : UIColor = UIColor.whiteColor()
        let purpleColor : UIColor = UIColor.purpleColor()
        let myWidth : CGFloat = 4
        let myRadius : CGFloat = 10
        
        workAndCarModel.layer.cornerRadius = myRadius
        workAndCarModel.layer.borderWidth = myWidth
        workAndCarModel.layer.borderColor = myColor.CGColor
        
        terugButton.layer.cornerRadius = myRadius
        terugButton.layer.borderWidth = myWidth
        terugButton.layer.borderColor = myColor.CGColor
        
        titleOfActivity.layer.cornerRadius = myRadius
        
        loggedInAtLabel.layer.cornerRadius = myRadius
        loggedInAtLabel.layer.borderWidth = myWidth
        loggedInAtLabel.layer.borderColor = myColor.CGColor
        
        headerForLabels.layer.cornerRadius = myRadius
        
        internBerichtView.layer.cornerRadius = myRadius
        internBerichtView.layer.borderWidth = myWidth
        internBerichtView.layer.borderColor = purpleColor.CGColor
        
        imprurenButton.layer.cornerRadius = myRadius
        imprurenButton.layer.borderWidth = myWidth
        imprurenButton.layer.borderColor = myColor.CGColor
        
        logOutButton.layer.cornerRadius = myRadius
        logOutButton.layer.borderWidth = myWidth
        logOutButton.layer.borderColor = myColor.CGColor
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loggedInAtLabel.text = "Ingeklokt op werkorder \(werkorder[0]) (\(werkorder[1]))"
        tableViewContainer.delegate = self
        tableViewContainer.dataSource = self
        
        tableViewContainer.registerClass(TableActivity.classForCoder(), forCellReuseIdentifier: "cellForActivity")
        
        if (huidigeWerkorder.count == 0){
            loggedInAtLabel.text = "Nog niet ingeklokt"
        }
        else{
            if (huidigeWerkorder[0] as! Int == werkorder[0]as! Int){
                loggedInAtLabel.backgroundColor = UIColor(red: 33/255, green: 169/255, blue: 6/255, alpha: 1)
                print(terugButton.backgroundColor)
                loggedInAtLabel.text = "Ingeklokt op werkorder \(werkorder[0]) (\(werkorder[1]))"
            }
            loggedInAtLabel.text = "Ingeklokt op werkorder \(huidigeWerkorder[0]) (\(huidigeWerkorder[1]))"
        }
        
        workOrder = werkorder[0] as! Int
        carModel = werkorder[2] as! String
        titleActivity = werkorder[3] as! String
        license = werkorder[1] as! String
      
     
        // set from segue
        carLicenceNum.text = license
        workAndCarModel.text = "WO " + String(workOrder) + ", " + carModel
        titleOfActivity.text = titleActivity
        
        
        sessionID = mainJson.sessieId
        activities = mainJson.getWerkOrderActiviteitenopKenteken(mainJson.getSessieId(), orderNummer: workOrder)
        setTableJsonData(activities)
       
        setLayout()

    }
    /*!
        @brief: geheugenmanagement. laat de IPad zelf het management doen
        @reason to be called: geheugen raakt vol
        @Params: none
        @output: none
    */
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setTableJsonData(activities: WerkOrderActiviteit) -> Array<Array<NSObject>> {
        tableData = []
        
        for (var x = 0; x < activities.activiteiten.count; x++) {
           
            for(var y = 0; y < activities.activiteiten[x]?.artikels.count; y++) {
                let verr = activities.activiteiten[x]?.artikels[y]
                print(verr?.aantal)
                print(verr?.artikelID)
                print(verr?.omschrijving)
                tableData.append([(verr?.artikelID)!, (verr?.aantal)!, (verr?.omschrijving)!])
            }
        }
        return tableData
        
    }
    
    /*!
        @brief Als er op uitklokken wordt gedrukt ga je terug naar het inlogscherm
        @output je komt bij het inlogscherm
    */
    @IBOutlet weak var logOutButton: UIButton!
    @IBAction func logOut(sender: UIButton) {
        performSegueWithIdentifier("logOutFromActivity", sender: nil)
    }
    
    // MARK: - Table view data source
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    /*!
        @brief geeft de tableview het juiste aantal rijen
        @output in de view wordt het aantal kolommen laten zien overeekomstig met de data op de server
    */
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
    
    /*!
        @brief zorgt ervoor dat elke cel van een rij gekoppeld wordt tot een rij
        @output return per rij een cel die bestaat uit de hele rij
    */
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // declare the cell as TableViewCell which is a separate class declared in a separate file
        let cell = tableView.dequeueReusableCellWithIdentifier("cellForActivity", forIndexPath: indexPath) as! TableActivity
        let row = indexPath.row      
        if(cell.exist==false){
        cell.setValueForColumn("\(tableData[row][0])", col:1)
        cell.setValueForColumn("\(tableData[row][1])", col:2)
        cell.setValueForColumn("\(tableData[row][2])", col:3)
        self.cellWidth = cell.layer.bounds.width
        setHeaderLabels()
        }
        if(row % 2 == 0) {
            cell.backgroundColor = UIColor.lightGrayColor()
        } else {
            cell.backgroundColor = UIColor.whiteColor()
        }

        return cell
        
    }
    
    /*!
        @brief maakt de titels voor de kolommen
        @output op het scherm zie je code, aantal en omschrijving boven een kolom staan
    */
    func setHeaderLabels () {
        // Sets the values for the headlines of table
        let col1Label = UILabel(frame: CGRectMake(0, 0.0, cellWidth/4.0, 30.0))
        let col2Label = UILabel(frame: CGRectMake(cellWidth/4.0, 0.0, cellWidth/8.0, 30.0))
        let col3Label = UILabel(frame: CGRectMake(cellWidth/4.0+cellWidth/8.0, 0.0, 3*cellWidth/8.0, 30.0))
        
        col1Label.text = "Code"
        col2Label.text = "Aantal"
        col3Label.text = "Omschrijving"
        
        self.headerForLabels.addSubview(col1Label)
        self.headerForLabels.addSubview(col2Label)
        self.headerForLabels.addSubview(col3Label)
    }
    
    /*
    *   @briefGeeft de variabelen door aan het volgende scherm.
    *
    *   Wordt aangeroepen door de app als laatste voor het volgende scherm wordt geladen
    *
    *   Short desciption of what variables are passed
    *
    *   @param segue    De verbinding tussen dit scherm en de volgende
    *   @param sender   De oorzaak van het overgaan naar het volgende scherm
    */
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        
        if (segue.identifier == "goToCamera") {
            // Create a new variable to store the instance of CameraView
            let destinationVC = segue.destinationViewController as! CameraView
        
            // Information that get send to CameraView
            destinationVC.licens = carLicenceNum.text
            destinationVC.activity = titleOfActivity.text
            destinationVC.work = workAndCarModel.text
        }
        if (segue.identifier == "goBackToWorkOrder") {
            let nac = segue.destinationViewController as! WerkOrderViewController
            nac.mainJson = mainJson
            nac.werkorder = werkorder
            nac.huidigeWerkorder = huidigeWerkorder
        }
        if (segue.identifier == "actToNonWork") {
            let nac = segue.destinationViewController as! nonWorkorderScreenController
            nac.mainJson = mainJson
            nac.werkorder = werkorder
            nac.huidigeWerkorder = huidigeWerkorder
        }
    }
        //Geeft een donkerdere kleur terug.
    func darkerColorForColor(color: UIColor) -> UIColor {
        var r:CGFloat = 0, g:CGFloat = 0, b:CGFloat = 0, a:CGFloat = 0
        if color.getRed(&r, green: &g, blue: &b, alpha: &a)
        {
            return UIColor(red: max(r - 0.2, 0.0), green: max(g - 0.2, 0.0), blue: max(b - 0.2, 0.0), alpha: a)
        }
        return UIColor()
        }
    

    
}

class UICustomView: UIView {
// Empty class for UICustomView if we want to add anything more to it...
}


