
//
//  activityController.swift
//  carMaintenance
//
//  Created by vmware on 05/11/15.
//  Copyright © 2015 vmware. All rights reserved.

import UIKit


class TableViewCellForActivity: UITableViewCell {
    var exist: Bool = false
    var newLabel1: UILabel!
    var newLabel2: UILabel!
    var newLabel3: UILabel!
    var newLabel4: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        for view in self.subviews {
            view.removeFromSuperview()
        }
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    
    func setValueForColumn(string: String, col:Int, width:CGFloat) {
        
        if (col==1) {
            newLabel1 = UILabel(frame: CGRectMake(0.0, 14.0, width*0.1, 30.0))
            newLabel1.numberOfLines = 0
            newLabel1.text = string
            exist = true
            self.addSubview(newLabel1)
        }
        if (col==2) {
            newLabel2 = UILabel(frame: CGRectMake(width*0.1, 14.0, width*0.15, 30.0))
            newLabel2.numberOfLines = 0
            newLabel2.text = string
            exist = true
            self.addSubview(newLabel2)
            
        }
        if (col==3) {
            newLabel3 = UILabel(frame: CGRectMake(width*0.25, 14.0, width*0.3, 30.0))
            newLabel3.numberOfLines = 0
            newLabel3.text = string
            exist = true
            self.addSubview(newLabel3)
        }
        if (col==4) {
            newLabel4 = UILabel(frame: CGRectMake(width*0.55, 14.0, width*0.45, 30.0))
            newLabel4.numberOfLines = 0
            newLabel4.text = string
            exist = true
            self.addSubview(newLabel4)
        }
    
    }
    
    func updateValueForColumn(string: Array<String>) {
        
        self.newLabel1.text = string[0]
        self.newLabel2.text = string[1]
        self.newLabel3.text = string[2]
        self.newLabel4.text = string[3]
    }
    
}


class WerkOrderController: UIViewController, UITableViewDelegate, UITableViewDataSource  {
    
    @IBOutlet weak var hashtagLabel: UILabel!
    @IBOutlet weak var tableViewContainer: UITableView!
    @IBOutlet weak var voertuigLabel: UILabel!
    @IBOutlet weak var kentekenLabel: UILabel!
    @IBOutlet weak var omschrijvingLabel: UILabel!
    @IBOutlet weak var ingekloktOpLabel: UILabel!
    @IBOutlet weak var werkorderLabel: UILabel!
    @IBOutlet weak var imprUrenButton: UIButton!
    @IBOutlet weak var outklokkenButton: UIButton!

    
    var mainJson :MainJson = MainJson()
    var werkOrderDetails :Array<WerkorderDetail> = []
    var tableData: Array <Array <Any>> = []
    var screenWidth: CGFloat = 0.0
    var selectedOrder = 0
    var monteurCode: String = ""
    var werkorder: Array<Any> = []
    var cells: Array <Any> = []

    @IBOutlet weak var otherWorkOrderButton: UIButton!
    @IBOutlet weak var myWorkOrderButton: UIButton!

    func setLayout(){
        let myColor : UIColor = UIColor.whiteColor()
        let myWidth : CGFloat = 4
        let myRadius : CGFloat = 10
    
        outklokkenButton.layer.cornerRadius = myRadius
        outklokkenButton.layer.borderWidth = myWidth
        outklokkenButton.layer.borderColor = myColor.CGColor
        
        imprUrenButton.layer.cornerRadius = myRadius
        imprUrenButton.layer.borderWidth = myWidth
        imprUrenButton.layer.borderColor = myColor.CGColor
        
        ingekloktOpLabel.layer.cornerRadius = myRadius
        ingekloktOpLabel.layer.borderWidth = myWidth
        ingekloktOpLabel.layer.borderColor = myColor.CGColor
        
        werkorderLabel.layer.cornerRadius = myRadius
        werkorderLabel.layer.borderWidth = myWidth
        werkorderLabel.layer.borderColor = myColor.CGColor
        
        otherWorkOrderButton.layer.cornerRadius = myRadius
        myWorkOrderButton.layer.cornerRadius = myRadius
        tableViewContainer.layer.cornerRadius = myRadius
    }
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        if (werkorder.count == 0){
            werkorderLabel.text = "Nog niet ingeklokt"
        }
        else{
            werkorderLabel.text = "Ingeklokt op werkorder \(werkorder[0]) (\(werkorder[1]))"
        }
        tableViewContainer.delegate = self
        tableViewContainer.dataSource = self
        
        tableViewContainer.registerClass(TableViewCellForActivity.classForCoder(), forCellReuseIdentifier: "cellForActivity")
        screenWidth = self.view.frame.size.width
        // print(currentWorkOrder)
        
        if (werkorder.count > 1) {
            ingekloktOpLabel.text = "Ingeklokt op werkorder \(werkorder[0]) (\(werkorder[1]))"
            ingekloktOpLabel.backgroundColor = UIColor(red: 33/255, green: 169/255, blue: 6/255, alpha: 1)
        }else
        {
            
            ingekloktOpLabel.text = "Niet ingeklokt op een werkorder"
        }
        getUserData(true)
        setLayout()
    }
    
    // brief: geheugenmanagement. laat de IPad zelf het management doen
    // reason to be called: geheugen raakt vol
    // Params: none
    // output: none
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    // MARK: - Table view data source
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return tableData.count
    }
    
    @IBAction func myWorkOrdersButton(sender: UIButton) {
        myWorkOrderButton.backgroundColor = UIColor.blackColor()
        otherWorkOrderButton.backgroundColor = UIColor(red: 48.0/255.0, green: 42.0/255.0, blue: 42.0/255.0, alpha: 1.0)
        getUserData(true)
    }
    
    
    @IBAction func otherWorkOrdersButton(sender: UIButton) {
        otherWorkOrderButton.backgroundColor = UIColor.blackColor()
        myWorkOrderButton.backgroundColor = UIColor(red: 48.0/255.0, green: 42.0/255.0, blue: 42.0/255.0, alpha: 1.0)
        getUserData(false)
    }
    
    func getUserData (myWorkOrder: Bool) {
        // empty the tableData
        tableData = []
        
        //for view in tableViewContainer.subviews {
        //    view.removeFromSuperview()
        //}
        
        // get user id
        if (myWorkOrder == true) {
            werkOrderDetails = mainJson.getWerkorder(mainJson.getSessieId(), monteurCode: monteurCode)
            for d in werkOrderDetails {
                tableData.append([d.nummer, d.kenteken, d.merk+" "+d.model, d.omschrijving])
            }
        }
        if (myWorkOrder == false) {
            werkOrderDetails = mainJson.getOtherWerkorders(mainJson.getSessieId(), monteurCode: monteurCode)
            for d in werkOrderDetails {
                tableData.append([d.nummer, d.kenteken, d.merk+" "+d.model, d.omschrijving + " other"])
            }
        }
        
        
        self.tableViewContainer.reloadData()
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.selectedOrder = indexPath.row
        performSegueWithIdentifier("werkordersNaarWerkorder", sender: nil)
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // declare the cell as TableViewCell which is a separate class declared in a separate file
        let cell = tableView.dequeueReusableCellWithIdentifier("cellForActivity", forIndexPath: indexPath) as! TableViewCellForActivity
        
        let row = indexPath.row
        if (cell.exist) {
            cell.newLabel1.text = "\(tableData[row][0])"
            cell.newLabel2.text = "\(tableData[row][1])"
            cell.newLabel3.text = "\(tableData[row][2])"
            cell.newLabel4.text = "\(tableData[row][3])"
        }
        else {
            cell.setValueForColumn("\(tableData[row][0])", col:1, width:screenWidth)
            cell.setValueForColumn("\(tableData[row][1])", col:2, width:screenWidth)
            cell.setValueForColumn("\(tableData[row][2])", col:3, width:screenWidth)
            cell.setValueForColumn("\(tableData[row][3])", col:4, width:screenWidth)
        }
        
        if(row % 2 == 0) {
            cell.backgroundColor = UIColor.lightGrayColor()
        }
            
        else {
            cell.backgroundColor = UIColor.whiteColor()
        }
        
        return cell
    }
    
    /*
    *   Geeft de variabelen door aan het volgende scherm.
    *
    *   Wordt aangeroepen door de app als laatste voor het volgende scherm wordt geladen
    *
    *   Short desciption of what variables are passed
    *
    *   @param segue    De verbinding tussen dit scherm en de volgende
    *   @param sender   De oorzaak van het overgaan naar het volgende scherm
    */
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "werkordersNaarWerkorder")
        {
            let lsvc = segue.destinationViewController as! WerkOrderViewController
            lsvc.werkorder  = tableData[selectedOrder]
            lsvc.monteurCode = monteurCode
            lsvc.mainJson = mainJson
            lsvc.huidigeWerkorder = werkorder
        }
        if (segue.identifier == "ordersNaarNonWork") {
            let nac = segue.destinationViewController as! nonWorkorderScreenController
            nac.mainJson = mainJson
            nac.werkorder = werkorder
            nac.huidigeWerkorder = werkorder
        }
        if (segue.identifier == "ordersNaarNonWork") {
            let nac = segue.destinationViewController as! nonWorkorderScreenController
            nac.mainJson = mainJson
            nac.werkorder = werkorder
        }
    }
}


