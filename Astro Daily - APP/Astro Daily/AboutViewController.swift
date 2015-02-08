//
//  AboutViewController.swift
//  Astro Daily
//
//  Created by Arefly on 22/1/2015.
//  Copyright (c) 2015年 Arefly. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class AboutViewController: UIViewController {      //设置视图
    
    @IBOutlet var versionLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        var version = NSBundle.mainBundle().objectForInfoDictionaryKey("CFBundleShortVersionString") as String
        var build = NSBundle.mainBundle().objectForInfoDictionaryKey(kCFBundleVersionKey as NSString) as String
    
        versionLabel.numberOfLines = 0;                               // Enable \n break line
        versionLabel.hidden = false;                                     // Disable Hidden
    
        versionLabel.text = "V " + version + " (Build " + build + ")"
    
    }
}