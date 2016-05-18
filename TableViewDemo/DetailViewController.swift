//
//  DetailViewController.swift
//  TableViewDemo
//
//  Created by LeNgocDuy on 5/18/16.
//  Copyright © 2016 Le Ngoc Duy. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

	@IBOutlet private var labelContent: UILabel!
	
	var content: String?
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		var description = ""
		if let content = content {
			description = content
			for _ in 0...10 {
				description += "\n \(content)"
			}
		}
		labelContent.text = description
	}

}
