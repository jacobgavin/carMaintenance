//
//  Activity.swift
//  carMaintenance
//
//  Created by vmware on 05/11/15.
//  Copyright © 2015 vmware. All rights reserved.
//

import Foundation

class Activity {
    var code:String?
    var amount:Int?
    var description:String?
    var group: String?
    
    init(code: String, amount: Int, description: String, group:String) {
        self.code = code
        self.amount = amount
        self.description = description
        self.group = group
    }
}