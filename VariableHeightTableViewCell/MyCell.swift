//
//  MyCell.swift
//  VariableHeightTableViewCell
//
//  Created by Nico Prananta on 7/12/15.
//  Copyright (c) 2015 DelightfulDev. All rights reserved.
//

import UIKit

class MyCell: UITableViewCell {

    @IBOutlet weak var myTitleLabel: UILabel!
    @IBOutlet weak var myDescriptionLabel: UILabel!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupSubviews()
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setupSubviews () {
        // we need to set the cell's width so that content view's width will be set correctly
        self.frame.size.width = UIScreen.mainScreen().applicationFrame.size.width
        
        self.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        
        if myTitleLabel == nil {
            let label = UILabel()
            label.backgroundColor = UIColor.blueColor()
            self.contentView.addSubview(label)
            myTitleLabel = label
        }
        if myDescriptionLabel == nil {
            let label = UILabel()
            label.backgroundColor = UIColor.orangeColor()
            self.contentView.addSubview(label)
            myDescriptionLabel = label
        }
        
        myTitleLabel.font = UIFont.boldSystemFontOfSize(17)
        myDescriptionLabel.font = UIFont.systemFontOfSize(14)
        myTitleLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        myTitleLabel.numberOfLines = 0
        myDescriptionLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        myDescriptionLabel.numberOfLines = 0
        myDescriptionLabel.setContentHuggingPriority(251, forAxis: UILayoutConstraintAxis.Vertical)
        
        var viewBindingsDict: NSMutableDictionary = NSMutableDictionary()
        viewBindingsDict.setValue(myTitleLabel, forKey: "label")
        viewBindingsDict.setValue(myDescriptionLabel, forKey: "description")
        let horizontalConstraints = NSLayoutConstraint.constraintsWithVisualFormat("H:|-10-[label]-10-|", options: nil, metrics: nil, views: viewBindingsDict as [NSObject : AnyObject]) as [AnyObject]
        let horizontalConstraints2 = NSLayoutConstraint.constraintsWithVisualFormat("H:|-10-[description]-10-|", options: nil, metrics: nil, views: viewBindingsDict as [NSObject : AnyObject]) as [AnyObject]
        let verticalConstraints = NSLayoutConstraint.constraintsWithVisualFormat("V:|-10-[label]-5-[description]-10-|", options: nil, metrics: nil, views: viewBindingsDict as [NSObject : AnyObject]) as [AnyObject]
        self.contentView.addConstraints(horizontalConstraints + horizontalConstraints2 + verticalConstraints)
        
        // in order for the table view and auto layout to calculate cell' height properly, we need to set preferredMaxLayoutWidth here
        self.layoutIfNeeded()
        myTitleLabel.preferredMaxLayoutWidth = myTitleLabel.frame.size.width
        myDescriptionLabel.preferredMaxLayoutWidth = myDescriptionLabel.frame.size.width
    }
}
