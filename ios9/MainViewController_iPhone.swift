//
//  MainViewController_iPhone.swift
//  ios9
//
//  Created by Ono Masashi on 2015/06/15.
//  Copyright © 2015年 akisute. All rights reserved.
//

import UIKit

class MainViewController_iPhone: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var tableView: UITableView!
    
    var layoutSize: CGSize = CGSizeZero
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.translatesAutoresizingMaskIntoConstraints = false
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.layoutSize = self.view.bounds.size
    }
    
    // MARK: - UITableViewDelegate, UITableViewDataSource
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        cell.textLabel?.text = "Compact"
        cell.detailTextLabel?.text = (self.layoutSize.width < self.layoutSize.height) ? "Portrait" : "Landscape"
        return cell
    }
    
    // MARK: - UIContentContainer
    
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransitionToSize(size, withTransitionCoordinator: coordinator)
        self.layoutSize = size
        self.tableView.beginUpdates()
        self.tableView.reloadSections(NSIndexSet(index: 0), withRowAnimation: .Fade)
        self.tableView.endUpdates()
    }
}
