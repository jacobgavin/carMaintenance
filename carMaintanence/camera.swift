//
//  camera.swift
//  carMaintenance
//
//  Created by vmware on 03/12/15.
//  Copyright © 2015 vmware. All rights reserved.
//

import Foundation
import UIKit


class CameraView: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet var imageView: UIImageView!
    
    @IBOutlet var licensField: UITextField!
    @IBOutlet var activityField: UITextField!
    @IBOutlet var workField: UITextField!
    
    var licens: String!
    var activity: String!
    var work: String!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup
        licensField.text = licens
        activityField.text = activity
        workField.text = work
    }
    
    
    // brief: geheugenmanagement. laat de IPad zelf het management doen
    // reason to be called: geheugen raakt vol
    // Params: none
    // output: none
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    @IBAction func chooseImageFromPhoto() {
        let picker = UIImagePickerController()
        
        picker.delegate = self
        picker.sourceType = .PhotoLibrary
        
        presentViewController(picker, animated: true, completion:nil)
    }
    
    @IBAction func chooseImageFromCamera() {
        let picker = UIImagePickerController()
        
        picker.delegate = self
        picker.sourceType = .Camera
        
        presentViewController(picker, animated: true, completion:nil)
    }
   

    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [NSObject : AnyObject]?) {
        imageView.image = image
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBOutlet weak var stackImageView: UIStackView!
    
    @IBAction func addPhotoToStack(sender: AnyObject) {
        let productImage:UIImageView = UIImageView(image: imageView.image)
        productImage.contentMode = .ScaleAspectFit
        self.stackImageView.addArrangedSubview(productImage)
        UIView.animateWithDuration(0.25, animations: {
            self.stackImageView.layoutIfNeeded()
        })
    }
}