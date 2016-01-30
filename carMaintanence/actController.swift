
//
//  activityController.swift
//  carMaintenance
//
//  Created by vmware on 05/11/15.
//  Copyright © 2015 vmware. All rights reserved.
//

import UIKit
class TableActivity: UITableViewCell {
    var column1: String = ""
    var column2: String = ""
    var column3: String = ""
    var width: CGFloat = 0.0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.width = self.layer.bounds.width
        
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func setValueForColumn(string: String, col:Int) {
        // frame: CGRectMake(x, y, width, height)
        let cellWidth = self.layer.bounds.width
        
        if (col==1) {
            let newLabel = UILabel(frame: CGRectMake(0, 0.0, cellWidth/4.0, 30.0))
            newLabel.numberOfLines = 0
            newLabel.text = string
            self.contentView.addSubview(newLabel)
        }
        if (col==2) {
            let newLabel = UILabel(frame: CGRectMake(cellWidth/4.0, 0.0, cellWidth/8.0, 30.0))
            newLabel.numberOfLines = 0
            newLabel.text = string
            self.contentView.addSubview(newLabel)
            
        }
        if (col==3) {
            let newLabel = UILabel(frame: CGRectMake(cellWidth/4.0+cellWidth/8.0, 0.0, 3*cellWidth/8.0, 30.0))
            newLabel.numberOfLines = 0
            newLabel.text = string
            self.contentView.addSubview(newLabel)
        }
        
    }
    
    func getWidth() -> CGFloat
    {
        return self.width
    }

    
}


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
    @IBOutlet weak var backButton: UIButton!  // not implemented
    @IBOutlet weak var tableViewContainer: UITableView!
    @IBOutlet weak var headerForLabels: UICustomView!
    var cellWidth: CGFloat = 0.0
    
    // json stuff
    var huidigeWerkorder: Array<Any> = []
    var werkorder: Array <Any> = [] //doorgeven van welke werkorder geselecteerd is in werkOrderController
    var activities: WerkOrderActiviteit = WerkOrderActiviteit()
    var mainJson: MainJson = MainJson()
    var sessionID: String = ""
    

    // This array is populated with data and every nested array is one row containing
    // 3 different string or whatever
    var tableData = [["Verrichting 1",0.5,"APK met viergastest"],["Onderd. 1",1,"Sticker 'APK zonder afspraak'"],[3.1,3.2,3.3]] // illustration only
  

    override func viewDidLoad() {
        super.viewDidLoad()
        loggedInAtLabel.text = "Ingeklokt op werkorder \(werkorder[0]) (\(werkorder[1]))"
        tableViewContainer.delegate = self
        tableViewContainer.dataSource = self
        
        tableViewContainer.registerClass(TableActivity.classForCoder(), forCellReuseIdentifier: "cellForActivity")
        
        if (huidigeWerkorder.count == 0){
            //huidigeWerkorder = werkorder
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

    }
    
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
    
    
    @IBOutlet weak var logOutButton: UIButton!
    @IBAction func logOut(sender: UIButton) {
        performSegueWithIdentifier("logOutFromActivity", sender: nil)
    }
    
    // MARK: - Table view data source
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // declare the cell as TableViewCell which is a separate class declared in a separate file
        let cell = tableView.dequeueReusableCellWithIdentifier("cellForActivity", forIndexPath: indexPath) as! TableActivity
        let row = indexPath.row

        cell.setValueForColumn("\(tableData[row][0])", col:1)
        cell.setValueForColumn("\(tableData[row][1])", col:2)
        cell.setValueForColumn("\(tableData[row][2])", col:3)
        self.cellWidth = cell.layer.bounds.width
        setHeaderLabels()
        
        if(row % 2 == 0) {
            cell.backgroundColor = UIColor.lightGrayColor()
        }
        
        else {
            cell.backgroundColor = UIColor.whiteColor()
        }
        
        return cell
        
    }
    

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
        }
    }

    
}

class UICustomView: UIView {
// Empty class for UICustomView if we want to add anything more to it...
}


