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

class workOrderController: UIViewController  {
    
    var workOrder = "1460"
    @IBOutlet weak var workOrderField: UILabel!
    @IBOutlet weak var logOutButton: UIButton!


    
    var employee: String = "test"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        workOrderField.text = "Ingeklokt op werkorder " + workOrder
        
        // Set logoutbutton to display name of employee
        
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    var myWorkOrders: Bool = false
    
    // Sets the myWorkOrders to true
    @IBAction func myWorkOrdersButton(sender: UIButton) {
        myWorkOrders = true
       
        
    }
    
    @IBAction func otherWorkOrdersButton(sender: UIButton) {
        myWorkOrders = false
       
    }
    
    
}

class customTableView: UITableViewController {
    var cellWidth: CGFloat = 0.0
    var cellIdentifier = "workOrderCell"
    var employee: String = ""
    
    var tableData: Array <Array <Any>> = []
    var myWorkOrders: Bool = false
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableData = [[1456 , "5-PST-9","Ford Mondeo", "Onderhoud"],[1460 , "9-ZKR-3","Opel Astra", "APK + bandenwissel"]]
        let tableView = self.tableView
        tableView.registerClass(TableViewCellForWorkOrder.classForCoder(), forCellReuseIdentifier:cellIdentifier)
        
        tableView.dataSource = self
        
        
        self.refreshControl = self.refreshControl
        
    }
    
    
    // MARK: - Table controller
    override func numberOfSectionsInTableView(tableView: UITableView ) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return tableData.count
    }
    
    func chooseWorkOrder (employee: String ) -> Array <Array <Any>> {
        
        if (myWorkOrders) {
            // From employee ID? get an array with all the workorders
            tableData = [[1456 , "5-PST-9","Ford Mondeo", "Onderhoud"],[1460 , "9-ZKR-3","Opel Astra", "APK + bandenwissel"]] // illustration only
        }
        else {
            // From all employees at employee ID workplace, return array with all workorders for employees at that workplace
            tableData = [[1337 , "ABC123","Tesla", "Syntax Error"],[2121 , "9-ZKR-3","Honda Cevic", "Big exhaust is broken again"]] // illustration only
        }
        return tableData
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // declare the cell as TableViewCell which is a separate class declared in a separate file
        let cell = tableView.dequeueReusableCellWithIdentifier("workOrderCell", forIndexPath: indexPath) as! TableViewCellForWorkOrder
        
        let row = indexPath.row
        
        
        
        cell.setValueForColumn("\(tableData[row][0])", col:1)
        cell.setValueForColumn("\(tableData[row][1])", col:2)
        cell.setValueForColumn("\(tableData[row][2])", col:3)
        cell.setValueForColumn("\(tableData[row][3])", col:4)
        self.cellWidth = cell.layer.bounds.width
        //setHeaderLabels()
        
        //if(row % 2 == 0) {
        //    cell.backgroundColor = UIColor.lightGrayColor()
        //}
            
        // else {
       //      cell.backgroundColor = UIColor.whiteColor()
       //  }
        
        return cell
        
    }
    
  
 //   func setHeaderLabels () {
 //       // Sets the values for the headlines of table
   //     let col1Label = UILabel(frame: CGRectMake(0, 14.0, cellWidth/5, 30.0))
//         let col2Label = UILabel(frame: CGRectMake(cellWidth/5, 14.0, cellWidth/5, 30.0))
//         let col3Label = UILabel(frame: CGRectMake((cellWidth/5)*2, 14.0, cellWidth/5, 30.0))
//         let col4Label = UILabel(frame: CGRectMake(cellWidth*0.6, 14.0, cellWidth*0.4, 30.0))
//
//         col1Label.text = "#"
//         col2Label.text = "Kenteken"
//         col3Label.text = "Voertuig"
//         col4Label.text = "Omschrijving"
//
//         self.view.addSubview(col1Label)
//         self.view.addSubview(col2Label)
//         self.view.addSubview(col3Label)
//         self.view.addSubview(col4Label)
//     }
}