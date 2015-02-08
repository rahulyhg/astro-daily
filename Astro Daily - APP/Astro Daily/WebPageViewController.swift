//
//  WebPageViewController.swift
//  星座運勢
//
//  Created by Arefly on 21/1/2015.
//  Copyright (c) 2015年 Arefly. All rights reserved.
//

import UIKit
import CoreData
import Foundation

class WebPageViewController: UIViewController {     //网页浏览视图
    @IBOutlet var day_webView: UIWebView!
    @IBOutlet var week_webView: UIWebView!
    @IBOutlet var disposition_webView: UIWebView!
    @IBOutlet var barnum_webView: UIWebView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UIApplication.sharedApplication().applicationIconBadgeNumber = 0;       //清除Home图标右上角的未读次数
        
        let defaults = NSUserDefaults.standardUserDefaults()
        
        var name = defaults.stringForKey("name") as String!
        var birthday = defaults.stringForKey("birthday") as String!
        
        if (name == nil) {
            var vc = self.storyboard?.instantiateViewControllerWithIdentifier("startView") as OptionViewController
            self.presentViewController(vc, animated: true, completion: nil)
        }
        if (birthday == nil) {
            var vc = self.storyboard?.instantiateViewControllerWithIdentifier("startView") as OptionViewController
            self.presentViewController(vc, animated: true, completion: nil)
        }
        
        if (name == nil) || (birthday == nil) {
            //DO NOTHING
        }else{
            if self.restorationIdentifier == "astro_day" {
                let day_url = NSURL(string: "http://file.arefly.com/astro/astro.php?type=day&birthday=" + birthday + "&name=" + name.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!)
                let day_url_request = NSURLRequest(URL: day_url!,
                    cachePolicy: NSURLRequestCachePolicy.ReloadIgnoringLocalAndRemoteCacheData,
                    timeoutInterval: 60*60*6)
                day_webView.loadRequest(day_url_request)
            } else if self.restorationIdentifier == "astro_week" {
                let week_url = NSURL(string: "http://file.arefly.com/astro/astro.php?type=week&birthday=" + birthday + "&name=" + name.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!)
                let week_url_request = NSURLRequest(URL: week_url!,
                    cachePolicy: NSURLRequestCachePolicy.ReloadIgnoringLocalAndRemoteCacheData,
                    timeoutInterval: 60*60*24*3)
                week_webView.loadRequest(week_url_request)
            } else if self.restorationIdentifier == "astro_disposition" {
                let disposition_url = NSURL(string: "http://file.arefly.com/astro/astro.php?type=disposition&birthday=" + birthday + "&name=" + name.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!)
                let disposition_url_request = NSURLRequest(URL: disposition_url!,
                    cachePolicy: NSURLRequestCachePolicy.ReloadIgnoringLocalAndRemoteCacheData,
                    timeoutInterval: 60*60*24*7)
                disposition_webView.loadRequest(disposition_url_request)
            } else if self.restorationIdentifier == "barnum_effect" {
                let barnum_url = NSURL(string: "http://file.arefly.com/astro/astro.php?type=barnum&birthday=" + birthday + "&name=" + name.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!)
                let barnum_url_request = NSURLRequest(URL: barnum_url!)
                barnum_webView.loadRequest(barnum_url_request)
            }
        }
        
      
        

        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
