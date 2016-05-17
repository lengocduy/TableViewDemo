//
//  StaticTableViewController.swift
//  TableViewDemo
//
//  Created by LeNgocDuy on 5/18/16.
//  Copyright © 2016 Le Ngoc Duy. All rights reserved.
//

import UIKit

class StaticTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
		let labelHeader = UILabel()
		labelHeader.text = "Table Header View"
		tableView.tableHeaderView = labelHeader
		
		let labelFooter = UILabel()
		labelFooter.text = "Table Footer View"
		tableView.tableFooterView = labelFooter
    }

}
