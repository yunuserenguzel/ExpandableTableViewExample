//
//  ExpandableCell.swift
//  ExpandableTableView
//
//  Created by Yunus Eren Guzel on 25/02/16.
//  Copyright © 2016 yeg. All rights reserved.
//

import UIKit

protocol ExpandableCellDelegate: class {
  
  func expandableCellHasChangedHeight(expandableCell: ExpandableCell)
  
}

class ExpandableCell: UITableViewCell {
  
  static let identifier = "ExpandableCell"
  
  weak var delegate: ExpandableCellDelegate?
  
  let titleButton = UIButton(type: .Custom)
  let descriptionLabel = UILabel()
  var descriptionLabelHeightConstraint: NSLayoutConstraint?
  
  override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    setupCell()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setupCell()
  }
  
  func setupCell() {
    selectionStyle = .None
    titleButton.translatesAutoresizingMaskIntoConstraints = false
    titleButton.setTitleColor(UIColor.blackColor(), forState: .Normal)
    titleButton.addTarget(self, action: "toggleDescription", forControlEvents: .TouchUpInside)
    titleButton.setTitle("Show Description", forState: .Normal)
    titleButton.setTitle("Hide Description", forState: .Selected)
    contentView.addSubview(titleButton)
    
    descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
    descriptionLabel.numberOfLines = 0
    contentView.addSubview(descriptionLabel)
    
    let views = [
      "title": titleButton,
      "description": descriptionLabel
    ]
    
    contentView.addConstraints(NSLayoutConstraint
      .constraintsWithVisualFormat("H:|[title]|", options: [], metrics: nil, views: views))
    contentView.addConstraints(NSLayoutConstraint
      .constraintsWithVisualFormat("H:|[description]|", options: [], metrics: nil, views: views))
    contentView.addConstraints(NSLayoutConstraint
      .constraintsWithVisualFormat("V:|[title(44)][description]-(>=0)-|", options: [], metrics: nil, views: views))
    descriptionLabelHeightConstraint = NSLayoutConstraint(item: descriptionLabel, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1, constant: 0)
    descriptionLabelHeightConstraint!.active = true
    contentView.addConstraint(descriptionLabelHeightConstraint!)
  }

  func toggleDescription() {
    titleButton.selected = !titleButton.selected
    descriptionLabelHeightConstraint?.active = !titleButton.selected
    delegate?.expandableCellHasChangedHeight(self)
  }
  
}
