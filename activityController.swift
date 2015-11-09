//
//  activityController.swift
//  carMaintenance
//
//  Created by vmware on 05/11/15.
//  Copyright © 2015 vmware. All rights reserved.
//

import UIKit
import Foundation

class activityController: UIViewController, UICollectionViewDataSource {
    
    let identifier = "activityCellIdentifier"
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    let dataSource = DataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.numberOfRowsInEachGroup(section)
    }
    
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return dataSource.groups.count
    }
    
    // The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(identifier, forIndexPath: indexPath) as! ActivityCell
        let activites: [Activity] = dataSource.activitesInGroup(indexPath.section)
        let activity: activites[indexPath.row]
        
        cell.backgroundColor = UIColor.blueColor()
        
        return cell
    }

   
}



