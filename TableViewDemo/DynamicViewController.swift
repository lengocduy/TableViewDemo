//
//  DynamicViewController.swift
//  TableViewDemo
//
//  Created by LeNgocDuy on 5/17/16.
//  Copyright © 2016 Le Ngoc Duy. All rights reserved.
//

import UIKit

class DynamicViewController: UIViewController {

	@IBOutlet var tableView: UITableView!
	
	override func viewDidLoad() {
		super.viewDidLoad()
	}

}

////////////////////////////////////////////////////////////////////////////


// MARK: UITab
////////////////////////////////////////////////////////////////////////////

extension DynamicViewController: UITableViewDataSource {
	func numberOfSectionsInTableView(tableView: UITableView) -> Int {
		return 1
	}
	
	func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 1
	}
	
	func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
		
		cell.textLabel?.text = "Text \n \n \(indexPath.row)"
		
		return cell
	}
}


////////////////////////////////////////////////////////////////////////////


// MARK: UIApplicationDelegate
////////////////////////////////////////////////////////////////////////////

extension DynamicViewController: UITableViewDelegate {
	func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
		return UITableViewAutomaticDimension
	}
	
	func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
		return UITableViewAutomaticDimension
	}
	
	func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
		
	}
	
}

////////////////////////////////////////////////////////////////////////////