//
//  DataSource.swift
//  carMaintenance
//
//  Created by vmware on 05/11/15.
//  Copyright © 2015 vmware. All rights reserved.
//

import Foundation

class DataSource {
    
    init() {
        populateData()
    }
    
    var activites: [Activity] = []
    var groups:[String] = []
    
    func numberOfRowsInEachGroup(index: Int) -> Int {
        return activitesInGroup(index).count
    }
    
    func numberOfGroups() -> Int {
        return groups.count
    }
    func getGroupLabelAtIndex(index: Int) -> String {
        return groups[index]
    }
    
    // MARK:- Populate Data from plist
    func populateData() {
        if let path = NSBundle.mainBundle().pathForResource("activites", ofType: "plist") {
            if let dictArray = NSArray(contentsOfFile: path) {
                for item in dictArray {
                    if let dict = item as? NSDictionary {
                        let code = dict["code"] as! String
                        let amount = dict["amount"] as! Int
                        let description = dict["description"] as! String
                        let group = dict["group"] as! String
                        
                        let activity = Activity(code: code, amount: amount, description: description, group: group)
                        if !groups.contains(group) {
                            groups.append(group)
                        }
                        activites.append(activity)
                    }
                }
            }
        }
    }
    
    // MARK:- ActivitesForEachGroup
    func activitesInGroup(index: Int) -> [Activity] {
        let item = groups[index]
        let filteredActivities = activites.filter { (activity: Activity) -> Bool in
            return activity.group == item
        }
        return filteredActivities
    }
}