
//
//  activityController.swift
//  carMaintenance
//
//  Created by vmware on 05/11/15.
//  Copyright © 2015 vmware. All rights reserved.
//

import UIKit
class TableViewCellForActivity: UITableViewCell {
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
        let width = self.layer.bounds.width
        print(width)
        if (col==1) {
            let newLabel = UILabel(frame: CGRectMake(0.0, 14.0, width/4, 30.0))
            newLabel.numberOfLines = 0
            newLabel.text = string
            self.contentView.addSubview(newLabel)
        }
        if (col==2) {
            let newLabel = UILabel(frame: CGRectMake(width/4, 14.0, width/4 , 30.0))
            newLabel.numberOfLines = 0
            newLabel.text = string
            self.contentView.addSubview(newLabel)
            
        }
        if (col==3) {
            let newLabel = UILabel(frame: CGRectMake(width/2, 14.0, width/2, 30.0))
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
    var regNum = "ABC 123"
    var workOrder = "1460"
    var carModel = "Volvo V70"
    var titleActivity = "Activiteit: APK"
    
    @IBOutlet weak var carLicenceNum: UITextField!
    @IBOutlet weak var workAndCarModel: UITextField!
    @IBOutlet weak var titleOfActivity: UITextField!
    
    @IBOutlet weak var tableViewContainer: UITableView!
    
    @IBOutlet weak var headerForLabels: UICustomView!
    var cellWidth: CGFloat = 0.0
    
    
    // This array is populated with data and every nested array is one row containing
    // 3 different string or whatever
    var tableData = [["Verrichting 1",0.5,"APK met viergastest"],["Onderd. 1",1,"Sticker 'APK zonder afspraak'"],[3.1,3.2,3.3]] // illustration only
  

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableViewContainer.delegate = self
        tableViewContainer.dataSource = self
        
        tableViewContainer.registerClass(TableViewCellForActivity.classForCoder(), forCellReuseIdentifier: "cellForActivity")
        
        carLicenceNum.text = regNum
        workAndCarModel.text = "WO " + workOrder + ", " + carModel
        titleOfActivity.text = titleActivity

    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    // MARK: - Table view data source
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 3
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // declare the cell as TableViewCell which is a separate class declared in a separate file
        let cell = tableView.dequeueReusableCellWithIdentifier("cellForActivity", forIndexPath: indexPath) as! TableViewCellForActivity
        
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
        let col1Label = UILabel(frame: CGRectMake(0, 14.0, cellWidth/4.0, 30.0))
        let col2Label = UILabel(frame: CGRectMake(cellWidth/4.0, 14.0, cellWidth/4.0, 30.0))
        let col3Label = UILabel(frame: CGRectMake(cellWidth/2.0, 14.0, cellWidth/2.0, 30.0))
        
        col1Label.text = "Code"
        col2Label.text = "Antal"
        col3Label.text = "Omschrijving"
        
        self.headerForLabels.addSubview(col1Label)
        self.headerForLabels.addSubview(col2Label)
        self.headerForLabels.addSubview(col3Label)
    }
    
    
}

class UICustomView: UIView {
    

    
}


