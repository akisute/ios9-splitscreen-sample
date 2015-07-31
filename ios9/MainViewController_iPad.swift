//
//  MainViewController_iPad.swift
//  ios9
//
//  Created by Ono Masashi on 2015/06/15.
//  Copyright © 2015年 akisute. All rights reserved.
//

import UIKit

class MainViewControllerCollectionViewCell: UICollectionViewCell {
    @IBOutlet var textLabel: UILabel!
    @IBOutlet var detailTextLabel: UILabel!
}

class MainViewController_iPad: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet var collectionView: UICollectionView!
    
    var layoutSize: CGSize = CGSizeZero
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.translatesAutoresizingMaskIntoConstraints = false
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.layoutSize = self.view.bounds.size
    }
    
    // MARK: - UICollectionViewDelegate, UICollectionViewDataSource
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as! MainViewControllerCollectionViewCell
        cell.textLabel.text = "Regular"
        cell.detailTextLabel.text = (self.layoutSize.width < self.layoutSize.height) ? "Portrait" : "Landscape"
        return cell
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return (self.layoutSize.width < self.layoutSize.height) ? CGSize(width: 150, height: 200) : CGSize(width: 200, height: 150)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return (self.layoutSize.width < self.layoutSize.height) ? UIEdgeInsets(top: 10.0, left: 20.0, bottom: 10.0, right: 20.0) : UIEdgeInsets(top: 10.0, left: 30.0, bottom: 10.0, right: 30.0)
    }

    
    // MARK: - UIContentContainer
    
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransitionToSize(size, withTransitionCoordinator: coordinator)
        self.layoutSize = size
        self.collectionView.reloadData()
    }
}
