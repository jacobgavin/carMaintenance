//
//  LoginScreenModel.swift
//  carMaintanence
//
//  Created by vmware on 20/10/15.
//  Copyright © 2015 vmware. All rights reserved.
//

import Foundation
class LoginScreenModel {
    var pincode = "1234";
    var pintry = ""
    var pinLabel = ""
    func setLabel(points: Int){
        pinLabel = ""
        if points>0{
            for _ in (0..<points){
                pinLabel += "•"
            }
        }
    }
    func getPinLabel() -> String{
        return pinLabel;
    }
    func checkPincode(pintry: String) ->	Bool{
        return pincode == pintry;
    }
    func addDigit(pinDigit: String) {
        pintry = pintry + pinDigit;
        print("pintry = \(pintry)")
        setLabel(pintry.characters.count)
    }
}


