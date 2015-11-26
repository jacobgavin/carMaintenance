
//
//  activityController.swift
//  carMaintenance
//
//  Created by vmware on 05/11/15.
//  Copyright © 2015 vmware. All rights reserved.
//

import UIKit
class TableViewCellForActivity: UITableViewCell {
    
    @IBOutlet weak var column1: UILabel!
    @IBOutlet weak var column2: UILabel!
    @IBOutlet weak var column3: UILabel!
    
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
            column1.text = string
        }
        if (col==2) {
            column2.text = string
        }
        if (col==3) {
            column3.text = string
        }
        
    }
    
}


class actController: UIViewController, UITableViewDelegate, UITableViewDataSource  {
    
    @IBOutlet weak var tableViewContainer: UITableView!
    
    @IBOutlet var tableCell: TableViewCellForActivity!
    
    var tableData = [[1.1,1.2,1.3],[2.1,2.2,2.3],[3.1,3.2,3.3]] // illustration only
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableViewContainer.delegate = self
        tableViewContainer.dataSource = self
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
        
        // var row = indexPath.row
        cell.setValueForColumn("col1", col:1)
        cell.setValueForColumn("col2", col:2)
        cell.setValueForColumn("col3", col:3)
        
        // cell.column1.text = "\(tableData[row][0])"// fill in your value for column 1 (e.g. from an array)
        // cell.column2.text = "\(tableData[row][1])" // fill in your value for column 2
        // cell.column3.text = "\(tableData[row][2])" // fill in your value for column 2
        
        return cell
    }
    
}


