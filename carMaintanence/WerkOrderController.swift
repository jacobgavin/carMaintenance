
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
    var col1Width: Int = 0
    var col2Width: Int = 0
    var col3Width: Int = 0
    var col4Width: Int = 0

    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    
    func setValueForColumn(string: String, col:Int) {
        
        if (col==1) {
            let newLabel = UILabel(frame: CGRectMake(12.0, 0.0, 58.0, 58.0))
            newLabel.text = string
            self.contentView.addSubview(newLabel)
        }
        if (col==2) {
            let newLabel = UILabel(frame: CGRectMake(60.0, 14.0, 92.0, 30.0))
            newLabel.text = string
            self.contentView.addSubview(newLabel)
            
        }
        if (col==3) {
            let newLabel = UILabel(frame: CGRectMake(170.0, 14.0, 300.0, 30.0))
            newLabel.text = string
            self.contentView.addSubview(newLabel)
        }
        if (col==4) {
            let newLabel = UILabel(frame: CGRectMake(300.0, 14.0, 300.0, 30.0))
            newLabel.text = string
            self.contentView.addSubview(newLabel)
        }
        
    }
    
}


class WerkOrderController: UIViewController, UITableViewDelegate, UITableViewDataSource  {
    
    @IBOutlet weak var hashtagLabel: UILabel!
    @IBOutlet weak var tableViewContainer: UITableView!
    @IBOutlet weak var voertuigLabel: UILabel!
    @IBOutlet weak var kentekenLabel: UILabel!
    @IBOutlet weak var omschrijvingLabel: UILabel!
    
    var mainJson :MainJson = MainJson()
    var werkOrderDetails :Array<WerkorderDetail> = []
    var tableData = [[1.1,1.2,1.3],[2.1,2.2,2.3],[3.1,3.2,3.3],[4.1,4.2,4.3]] // illustration only
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewContainer.delegate = self
        tableViewContainer.dataSource = self
        
        tableViewContainer.registerClass(TableViewCellForActivity.classForCoder(), forCellReuseIdentifier: "cellForActivity")
        
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
        werkOrderDetails = mainJson.getWerkorder(mainJson.getSessieId())
        let cell = tableView.dequeueReusableCellWithIdentifier("cellForActivity", forIndexPath: indexPath) as! TableViewCellForActivity
        
        // var row = indexPath.row
        cell.setValueForColumn("\(werkOrderDetails[indexPath.row].nummer)", col:1)
        cell.setValueForColumn("\(werkOrderDetails[indexPath.row].kenteken)", col:2)
        cell.setValueForColumn("\(werkOrderDetails[indexPath.row].model)", col:3)
        cell.setValueForColumn("\(werkOrderDetails[indexPath.row].omschrijving)", col:4)
        // cell.column1.text = "\(tableData[row][0])"// fill in your value for column 1 (e.g. from an array)
        // cell.column2.text = "\(tableData[row][1])" // fill in your value for column 2
        // cell.column3.text = "\(tableData[row][2])" // fill in your value for column 2
        
        return cell
    }
    
}


