//
//  ViewController.swift
//  ExpandableTableView
//
//  Created by Yunus Eren Guzel on 25/02/16.
//  Copyright © 2016 yeg. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, ExpandableCellDelegate {
  
  let tableView = UITableView()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.translatesAutoresizingMaskIntoConstraints = false
    tableView.delegate = self
    tableView.dataSource = self
    tableView.registerClass(ExpandableCell.self, forCellReuseIdentifier: ExpandableCell.identifier)
    tableView.rowHeight = UITableViewAutomaticDimension
    tableView.estimatedRowHeight = 66
    view.addSubview(tableView)
    view.addConstraints(NSLayoutConstraint
      .constraintsWithVisualFormat("H:|[table]|", options: [], metrics: nil, views: ["table":tableView]))
    view.addConstraints(NSLayoutConstraint
      .constraintsWithVisualFormat("V:|[table]|", options: [], metrics: nil, views: ["table":tableView]))
    // Do any additional setup after loading the view, typically from a nib.
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier(ExpandableCell.identifier, forIndexPath: indexPath) as! ExpandableCell
    cell.delegate = self
    cell.descriptionLabel.text = "Lorem Ipsum, dizgi ve baskı endüstrisinde kullanılan mıgır metinlerdir. Lorem Ipsum, adı bilinmeyen bir matbaacının bir hurufat numune kitabı oluşturmak üzere bir yazı galerisini alarak karıştırdığı 1500'lerden beri endüstri standardı sahte metinler olarak kullanılmıştır. Beşyüz yıl boyunca varlığını sürdürmekle kalmamış, aynı zamanda pek değişmeden elektronik dizgiye de sıçramıştır. 1960'larda Lorem Ipsum pasajları da içeren Letraset yapraklarının yayınlanması ile ve yakın zamanda Aldus PageMaker gibi Lorem Ipsum sürümleri içeren masaüstü yayıncılık yazılımları ile popüler olmuştur."
    return cell
  }
  
  func expandableCellHasChangedHeight(expandableCell: ExpandableCell) {
    UIView.animateWithDuration(0.3) {
      expandableCell.contentView.layoutIfNeeded()
    }
    tableView.beginUpdates()
    tableView.endUpdates()
  }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 100
  }
  
  func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 1
  }
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    tableView.reloadData()
  }

}

