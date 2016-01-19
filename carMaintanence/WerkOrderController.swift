
//
//  activityController.swift
//  carMaintenance
//
//  Created by vmware on 05/11/15.
//  Copyright © 2015 vmware. All rights reserved.
//

import UIKit


class TableViewCellForActivity: UITableViewCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    
    func setValueForColumn(string: String, col:Int, width:CGFloat) {
        
        if (col==1) {
            let newLabel = UILabel(frame: CGRectMake(0.0, 14.0, width*0.1, 30.0))
            newLabel.numberOfLines = 0
            newLabel.text = string
            self.contentView.addSubview(newLabel)
        }
        if (col==2) {
            let newLabel = UILabel(frame: CGRectMake(width*0.1, 14.0, width*0.15, 30.0))
            newLabel.numberOfLines = 0
            newLabel.text = string
            self.contentView.addSubview(newLabel)
            
        }
        if (col==3) {
            let newLabel = UILabel(frame: CGRectMake(width*0.25, 14.0, width*0.3, 30.0))
            newLabel.numberOfLines = 0
            newLabel.text = string
            self.contentView.addSubview(newLabel)
        }
        if (col==4) {
            let newLabel = UILabel(frame: CGRectMake(width*0.55, 14.0, width*0.45, 30.0))
            newLabel.numberOfLines = 0
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
    var tableData: Array <Array <Any>> = []
    var screenWidth: CGFloat = 0.0
    var selectedOrder = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewContainer.delegate = self
        tableViewContainer.dataSource = self
        
        tableViewContainer.registerClass(TableViewCellForActivity.classForCoder(), forCellReuseIdentifier: "cellForActivity")
        tableData = [] // illustration only
        screenWidth = self.view.frame.size.width
        getUserData()
    }
    
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
    
    func getUserData () {
        // get user id
        werkOrderDetails = mainJson.getWerkorder(mainJson.getSessieId())
        for d in werkOrderDetails {
            tableData.append([d.nummer, d.kenteken, d.merk+" "+d.model, d.omschrijving])
        }
    
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.selectedOrder = indexPath.row
        performSegueWithIdentifier("werkordersNaarWerkorder", sender: nil)
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // declare the cell as TableViewCell which is a separate class declared in a separate file
        let cell = tableView.dequeueReusableCellWithIdentifier("cellForActivity", forIndexPath: indexPath) as! TableViewCellForActivity
        
        let row = indexPath.row
        print(tableData)
        cell.setValueForColumn("\(tableData[row][0])", col:1, width:screenWidth)
        cell.setValueForColumn("\(tableData[row][1])", col:2, width:screenWidth)
        cell.setValueForColumn("\(tableData[row][2])", col:3, width:screenWidth)
        cell.setValueForColumn("\(tableData[row][3])", col:4, width:screenWidth)
        
        return cell
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "werkordersNaarWerkorder")
        {
            let lsvc = segue.destinationViewController as! WerkOrderViewController
            lsvc.werkorder  = tableData[selectedOrder
            ]
            print( tableData[selectedOrder][1])
            lsvc.mainJson = mainJson
        }
    }
}


