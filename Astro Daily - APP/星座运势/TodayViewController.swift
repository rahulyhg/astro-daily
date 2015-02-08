//
//  TodayViewController.swift
//  星座运势
//
//  Created by Arefly on 24/1/2015.
//  Copyright (c) 2015年 Arefly. All rights reserved.
//

import UIKit
import NotificationCenter

class TodayViewController: UIViewController, NCWidgetProviding {
    
        
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view from its nib.
        
        let defaults = NSUserDefaults.standardUserDefaults()
        
        var name = defaults.stringForKey("name") as String!
        var birthday = defaults.stringForKey("birthday") as String!
        
        println(name)
    }
    
    func get_daily_json()
    {
        var url = NSURL(string: "http://www.weather.com.cn/data/cityinfo/101010100.html")
        var data = NSData(contentsOfURL: url!)
        var str = NSString(data: data!, encoding: NSUTF8StringEncoding)
        println(str)
        var json : AnyObject! = NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments, error: nil)
        let weatherinfo: AnyObject = json.objectForKey("weatherinfo")!
        /*
city.text = weatherinfo.objectForKey("city") as String
        cityid.text = weatherinfo.objectForKey("cityid") as String
        temp1.text = weatherinfo.objectForKey("temp1") as String
        temp2.text = weatherinfo.objectForKey("temp2") as String
        weather.text = weatherinfo.objectForKey("weather") as String
        img1.text = weatherinfo.objectForKey("img1") as String
        img2.text = weatherinfo.objectForKey("img2") as String
        ptime.text = weatherinfo.objectForKey("ptime") as String
*/
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func widgetPerformUpdateWithCompletionHandler(completionHandler: ((NCUpdateResult) -> Void)!) {
        // Perform any setup necessary in order to update the view.

        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData

        completionHandler(NCUpdateResult.NewData)
    }
    
}
