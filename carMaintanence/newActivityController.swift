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
    var mainJson: MainJson = MainJson()
    var werkorder: Array<Any> = []
    var huidigeWerkorder: Array<Any> = []
    let placeholder_text = "Omschrijving van Activiteit"
    
    func setLayout(){
        let myColor : UIColor = UIColor.whiteColor()
        let purpleColor : UIColor = UIColor.purpleColor()
        let myWidth : CGFloat = 4
        let myRadius : CGFloat = 10
        
        
        titleOfNewActivity.layer.borderColor = myColor.CGColor
        
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
        loggedInOnWorkOrder.text = "Aanpassen voor werkorder \(werkorder[0]) (\(werkorder[1]))"
        loggedInOnWorkOrder.layer.borderColor = myColor.CGColor
        loggedInOnWorkOrder.layer.borderWidth = myWidth
        loggedInOnWorkOrder.layer.masksToBounds = true
        
        logOutButton.layer.cornerRadius = myRadius
        logOutButton.layer.borderWidth = myWidth
        logOutButton.layer.cornerRadius = myRadius
        logOutButton.layer.borderColor = myColor.CGColor
        
        descTextField.layer.borderColor = purpleColor.CGColor
        descTextField.layer.borderWidth = myWidth
        descTextField.layer.cornerRadius = myRadius
        descTextField.text = ""
        
        //regNum = werkorder[1] as! String
        // Do any additional setup after loading the view, typically from a nib.
        
        //regNumberOfCar.text = regNum


        regNumberOfCar.text = (werkorder[1] as! String)
        regNumberOfCar.userInteractionEnabled = false
        
        //workNumAndCarModel.text = "WO \(werkorder[0]), \(werkorder[2])"
        workNumAndCarModel.userInteractionEnabled = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLayout()  
        //loggedInOnWorkOrder.text = "Ingeklokt op werkorder " + workOrder + "("+regNum+")"
    }
    
    func textViewDidBeginEditing(textview: UITextView){
        if (textview.text == "Omschrijving van de Activiteit"){
            textview.text = nil        
        }
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
        mainJson.opslaanActiviteit("VR-786-L", sessieId: mainJson.getSessieId(), omschrijving: "lslkfjlskdjflksjfd",id: 42, code: "codeiets")
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "nieuweActiviteitNaarWerkorder"){
            let wovc = segue.destinationViewController as! WerkOrderViewController
            wovc.mainJson = mainJson
            wovc.werkorder = werkorder
            wovc.huidigeWerkorder = huidigeWerkorder
        }
    }
    
    
}
