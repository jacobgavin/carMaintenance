//
//  newActivityController.swift
//  carMaintenance
//
//  Created by vmware on 29/10/15.
//  Copyright © 2015 vmware. All rights reserved.
//

import UIKit



class newActivityController: UIViewController {
    var regNum = "ABC 123"
    var workOrder = "1460"
    var carModel = "Volvo V70"

    override func viewDidLoad() {
        super.viewDidLoad()
        let myColor : UIColor = UIColor.whiteColor()
        let purpleColor : UIColor = UIColor.purpleColor()
        let myWidth : CGFloat = 2.0
        let myRadius : CGFloat = 10
        
        titleOfNewActivity.layer.borderColor = myColor.CGColor
        titleOfNewActivity.layer.borderWidth = myWidth
        titleOfNewActivity.layer.cornerRadius = myRadius
        
        workNumAndCarModel.layer.borderColor = myColor.CGColor
        workNumAndCarModel.layer.borderWidth = myWidth
        workNumAndCarModel.layer.cornerRadius = myRadius
        
        newActivityButton.layer.borderColor = myColor.CGColor
        newActivityButton.layer.borderWidth = myWidth
        newActivityButton.layer.cornerRadius = myRadius
        
        cameraButton.layer.borderColor = myColor.CGColor
        cameraButton.layer.borderWidth = myWidth
        cameraButton.layer.cornerRadius = myRadius
        
        editButton.layer.borderColor = myColor.CGColor
        editButton.layer.borderWidth = myWidth
        editButton.layer.cornerRadius = myRadius
        
        loggedInOnWorkOrder.layer.cornerRadius = myRadius
        logOutButton.layer.cornerRadius = myRadius
        
        descTextField.layer.borderColor = purpleColor.CGColor
        descTextField.layer.borderWidth = myWidth
        descTextField.layer.cornerRadius = myRadius
        
        // Do any additional setup after loading the view, typically from a nib.
        regNumberOfCar.text = regNum
        workNumAndCarModel.text = "WO " + workOrder + ", " + carModel
        loggedInOnWorkOrder.text = "Ingeklokt op werkorder " + workOrder + "("+regNum+")"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var logOutButton: UIButton!
    
    @IBOutlet weak var loggedInOnWorkOrder: UILabel!
    
    @IBOutlet weak var regNumberOfCar: UITextField!
    
    @IBOutlet weak var workNumAndCarModel: UITextField!
    
    @IBOutlet weak var descTextField: UITextView! // the Editable textfield
    
    @IBOutlet weak var titleOfNewActivity: UITextField!
    
    @IBOutlet weak var newActivityButton: UIButton!
    
    @IBOutlet weak var cameraButton: UIButton!
    
    @IBOutlet weak var editButton: UIButton!
    
    @IBAction func saveButton(sender: UIButton) {
        let title = titleOfNewActivity.text!
        let description = descTextField.text!
        print(title)
        print(description)
    }
    
    
}
