//
//  ViewController.swift
//  VariableHeightTableViewCell
//
//  Created by Nico Prananta on 7/12/15.
//  Copyright (c) 2015 DelightfulDev. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    var licenses = [AnyObject]()
    let cellIdentifier = "cellIdentifier"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadLicenses()
        
        // Uncomment one of these two lines to choose between nib or class to register MyCell
        self.tableView.registerClass(MyCell.classForCoder(), forCellReuseIdentifier: cellIdentifier)
        //self.tableView.registerNib(UINib(nibName: "MyCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: cellIdentifier)
        
        self.tableView.estimatedRowHeight = 60
        self.tableView.rowHeight = UITableViewAutomaticDimension
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadLicenses () {
        let licensesPath = NSBundle.mainBundle().pathForResource("Licenses", ofType: "plist")
        let licensesData = NSFileManager.defaultManager().contentsAtPath(licensesPath!)
        var error: NSError?
        let licensesDictionary = NSPropertyListSerialization.propertyListWithData(licensesData!, options: Int(NSPropertyListMutabilityOptions.MutableContainersAndLeaves.rawValue), format: nil, error: &error) as! Dictionary<String, AnyObject>

        licenses = sorted(licensesDictionary.keys).map() {
            var license = licensesDictionary[$0] as! Dictionary<String, AnyObject>
            license["name"] = $0
            return license
        }
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return licenses.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! MyCell
        let license = licenses[indexPath.row] as! Dictionary<String, AnyObject>
        cell.myTitleLabel.text = license["name"] as? String
        cell.myDescriptionLabel.text = license["Description"] as? String
        
        cell.setNeedsUpdateConstraints()
        cell.updateConstraintsIfNeeded()
        return cell
    }
}

