//
//  DynamicViewController.swift
//  TableViewDemo
//
//  Created by LeNgocDuy on 5/17/16.
//  Copyright © 2016 Le Ngoc Duy. All rights reserved.
//

import UIKit
import MobileCoreServices
import CoreSpotlight

class DynamicViewController: UIViewController {

	@IBOutlet var tableView: UITableView!
	var projects = [[String]]()
	var favorites = [Int]()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		projects.append(["Project 1: Storm Viewer", "Constants and variables, UITableView, UIImageView, NSFileManager, storyboards"])
		projects.append(["Project 2: Guess the Flag", "@2x and @3x images, asset catalogs, integers, doubles, floats, operators (+= and -=), UIButton, enums, CALayer, UIColor, random numbers, actions, string interpolation, UIAlertController"])
		projects.append(["Project 3: Social Media", "UIBarButtonItem, UIActivityViewController, the Social framework, NSURL"])
		projects.append(["Project 4: Easy Browser", "loadView(), WKWebView, delegation, classes and structs, NSURLRequest, UIToolbar, UIProgressView., key-value observing"])
		projects.append(["Project 5: Word Scramble", "NSString, closures, method return values, booleans, NSRange"])
		projects.append(["Project 6: Auto Layout", "Get to grips with Auto Layout using practical examples and code"])
		projects.append(["Project 7: Whitehouse Petitions", "JSON, NSData, UITabBarController"])
		projects.append(["Project 8: 7 Swifty Words", "addTarget(), enumerate(), countElements(), find(), join(), property observers, range operators."])
		
		let defaults = NSUserDefaults.standardUserDefaults()
		if let savedFavorites = defaults.objectForKey("favorites") as? [Int] {
			favorites = savedFavorites
		}
		
		tableView.editing = true
		tableView.allowsSelectionDuringEditing = true

        let labelHeader = UILabel(frame: CGRect(origin: CGPointZero, size: CGSize(width: tableView.frame.width, height: 50)))
        labelHeader.textAlignment = .Center
        labelHeader.backgroundColor = UIColor.greenColor()
        labelHeader.text = "Demo TableView Header"
        tableView.tableHeaderView = labelHeader

        let labelFooter = UILabel(frame: CGRect(origin: CGPointZero, size: CGSize(width: tableView.frame.width, height: 50)))
        labelFooter.textAlignment = .Center
        labelFooter.backgroundColor = UIColor.greenColor()
        labelFooter.text = "Demo TableView Footer"
        tableView.tableFooterView = labelFooter
	}
	
	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
		if let desVC = segue.destinationViewController as? DetailViewController {
			if let content = sender as? String {
				desVC.content = content
			}
		}
	}

}

////////////////////////////////////////////////////////////////////////////


// MARK: UITab
////////////////////////////////////////////////////////////////////////////

extension DynamicViewController: UITableViewDataSource {
	func numberOfSectionsInTableView(tableView: UITableView) -> Int {
		return 2
	}
	
	func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return projects.count
	}
	
	func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCellWithIdentifier("DynamicCell", forIndexPath: indexPath) as! DynamicCell
		
		let project = projects[indexPath.row]
		cell.labelRowIndex.text = project[0]
		cell.labelContent.text = project[1]
		
		if favorites.contains(indexPath.row) {
			cell.editingAccessoryType = .Checkmark
		} else {
			cell.editingAccessoryType = .None
		}
		
		return cell
	}

    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Section \(section)"
    }

	func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCellEditingStyle {
		if favorites.contains(indexPath.row) {
			return .Delete
		} else {
			return .Insert
		}
	}
	
	func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
		if editingStyle == .Insert {
			favorites.append(indexPath.row)
			indexItem(indexPath.row)
		} else {
			if let index = favorites.indexOf(indexPath.row) {
				favorites.removeAtIndex(index)
				deindexItem(indexPath.row)
			}
		}
		
		let defaults = NSUserDefaults.standardUserDefaults()
		defaults.setObject(favorites, forKey: "favorites")
		
		tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: .None)
	}
	
	func indexItem(which: Int) {
		let project = projects[which]
		
		let attributeSet = CSSearchableItemAttributeSet(itemContentType: kUTTypeText as String)
		attributeSet.title = project[0]
		attributeSet.contentDescription = project[1]
		
		let item = CSSearchableItem(uniqueIdentifier: "\(which)", domainIdentifier: "com.hackingwithswift", attributeSet: attributeSet)
		CSSearchableIndex.defaultSearchableIndex().indexSearchableItems([item]) { (error: NSError?) -> Void in
			if let error = error {
				print("Indexing error: \(error.localizedDescription)")
			} else {
				print("Search item successfully indexed!")
			}
		}
	}
	
	func deindexItem(which: Int) {
		CSSearchableIndex.defaultSearchableIndex().deleteSearchableItemsWithIdentifiers(["\(which)"]) { (error: NSError?) -> Void in
			if let error = error {
				print("Deindexing error: \(error.localizedDescription)")
			} else {
				print("Search item successfully removed!")
			}
		}
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
		tableView.deselectRowAtIndexPath(indexPath, animated: true)
		performSegueWithIdentifier("ShowDetail", sender: projects[indexPath.row][1])
	}

    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }

}

////////////////////////////////////////////////////////////////////////////