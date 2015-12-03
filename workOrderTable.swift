//
//  workOrderTable.swift
//  carMaintenance
//
//  Created by vmware on 03/12/15.
//  Copyright © 2015 vmware. All rights reserved.
//

import Foundation
import UIKit

class TableViewCellForWorkOrder: UITableViewCell {
    var column1: String = ""
    var column2: String = ""
    var column3: String = ""
    var column4: String = ""
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
            let newLabel = UILabel(frame: CGRectMake(0.0, 14.0, width/5, 30.0))
            newLabel.numberOfLines = 0
            newLabel.text = string
            self.contentView.addSubview(newLabel)
        }
        if (col==2) {
            let newLabel = UILabel(frame: CGRectMake(width/5, 14.0, width/5 , 30.0))
            newLabel.numberOfLines = 0
            newLabel.text = string
            self.contentView.addSubview(newLabel)
            
        }
        if (col==3) {
            let newLabel = UILabel(frame: CGRectMake((width/5)*2, 14.0, width/5, 30.0))
            newLabel.numberOfLines = 0
            newLabel.text = string
            self.contentView.addSubview(newLabel)
        }
        if (col==4) {
            let newLabel = UILabel(frame: CGRectMake(width*0.6, 14.0, width*0.4, 30.0))
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

class workOrderController: UIViewController, UITableViewDelegate, UITableViewDataSource  {
    
    var workOrder = "1460"
    
    @IBOutlet weak var workOrderField: UILabel!
    @IBOutlet weak var tableViewContainer: UITableView!
    @IBOutlet weak var headerForLabels: UICustomViewWorkOrder!
    
    var cellWidth: CGFloat = 0.0
    
    
    // This array is populated with data and every nested array is one row containing
    // 3 different string or whatever
    var tableData = [[1456 , "5-PST-9","Ford Mondeo", "Onderhoud"],[1460 , "9-ZKR-3","Opel Astra", "APK + bandenwissel"]] // illustration only
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableViewContainer.delegate = self
        tableViewContainer.dataSource = self
        
        tableViewContainer.registerClass(TableViewCellForWorkOrder.classForCoder(), forCellReuseIdentifier: "workOrderCell")
        
        workOrderField.text = "Ingeklokt op werkorder " + workOrder
        
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    // MARK: - Table view data source
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 2
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // declare the cell as TableViewCell which is a separate class declared in a separate file
        let cell = tableView.dequeueReusableCellWithIdentifier("workOrderCell", forIndexPath: indexPath) as! TableViewCellForWorkOrder
        
        let row = indexPath.row
        
        
        cell.setValueForColumn("\(tableData[row][0])", col:1)
        cell.setValueForColumn("\(tableData[row][1])", col:2)
        cell.setValueForColumn("\(tableData[row][2])", col:3)
        cell.setValueForColumn("\(tableData[row][3])", col:4)
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
        let col1Label = UILabel(frame: CGRectMake(0, 14.0, cellWidth/5, 30.0))
        let col2Label = UILabel(frame: CGRectMake(cellWidth/5, 14.0, cellWidth/5, 30.0))
        let col3Label = UILabel(frame: CGRectMake((cellWidth/5)*2, 14.0, cellWidth/5, 30.0))
        let col4Label = UILabel(frame: CGRectMake(cellWidth*0.6, 14.0, cellWidth*0.4, 30.0))
        
        col1Label.text = "#"
        col2Label.text = "Kenteken"
        col3Label.text = "Voertuig"
        col4Label.text = "Omschrijving"
        
        self.headerForLabels.addSubview(col1Label)
        self.headerForLabels.addSubview(col2Label)
        self.headerForLabels.addSubview(col3Label)
        self.headerForLabels.addSubview(col4Label)
    }
    
    
    
    
}

class UICustomViewWorkOrder: UIView {
    
    
    
}