//
//  MyCell.swift
//  VariableHeightTableViewCell
//
//  Created by Nico Prananta on 7/12/15.
//  Copyright (c) 2015 DelightfulDev. All rights reserved.
//

import UIKit

class MyCell: UITableViewCell {
    let myTitleLabel = UILabel()
    let myDescriptionLabel = UILabel()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupSubviews()
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setupSubviews () {
        self.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        
        myTitleLabel.font = UIFont.boldSystemFontOfSize(17)
        myDescriptionLabel.font = UIFont.systemFontOfSize(14)
        
        if myTitleLabel.superview == nil {
            self.contentView.addSubview(myTitleLabel)
        }
        if myDescriptionLabel.superview == nil {
            self.contentView.addSubview(myDescriptionLabel)
        }
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
    }
}
