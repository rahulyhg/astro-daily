//
//  OptionViewController.swift
//  星座運勢
//
//  Created by Arefly on 21/1/2015.
//  Copyright (c) 2015年 Arefly. All rights reserved.
//

import UIKit
import CoreData
import Foundation


class OptionViewController: UIViewController {      //设置视图
    
    var name = [NSManagedObject]()
    var birthday = [NSManagedObject]()
    
    @IBOutlet var welcomeLabel: UILabel!
    
    @IBOutlet var datePicker: UITextField!
    @IBOutlet var user_name: UITextField!
    
    @IBOutlet var versionLabel: UILabel!
    @IBOutlet var made_by_arefly: UILabel!
    
    @IBOutlet var noticeTimePicker: UIDatePicker!
    @IBOutlet var noticeSwitch: UISwitch!
    @IBOutlet var noticeHiddenTime: UITextField!
    
    var localNotification = UILocalNotification()   // You just need one
    var notificationsCounter = 0
    
    
    
    @IBAction func onTouchedSave(sender: AnyObject) {

        if (datePicker.text.isEmpty) || (user_name.text.isEmpty) {
            let alert = UIAlertView()
            alert.title = "错误！"
            alert.message = "请输入姓名或生日！"
            alert.addButtonWithTitle("确定")
            alert.show()
        }else{
            var userDefault = NSUserDefaults.standardUserDefaults()
            
            var name:String = user_name.text
            var name_without_spaces = name.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
            userDefault.setObject(name_without_spaces, forKey: "name")
            //userDefault.del(name, forKey: "name")
            userDefault.synchronize()
            
            var birthday:String = datePicker.text
            var birthday_without_spaces = birthday.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
            userDefault.setObject(birthday_without_spaces, forKey: "birthday")
            userDefault.synchronize()
            
            var noticeTime = noticeHiddenTime.text
            userDefault.setObject(noticeTime, forKey: "noticeTime")
            userDefault.synchronize()
            
            
            

            
            
            let alert = UIAlertView()
            alert.title = "完成！"
            alert.message = "已储存您的姓名及日期！"
            alert.addButtonWithTitle("确定")
            alert.show()
            
            /* 清空网页缓存开始 */
            NSURLCache.sharedURLCache().removeAllCachedResponses()
            NSURLCache.sharedURLCache().diskCapacity = 0
            NSURLCache.sharedURLCache().memoryCapacity = 0
            /* 清空网页缓存结束 */
            
            
            
            
            UIApplication.sharedApplication().cancelAllLocalNotifications()
            
            var optionsNoticeTime = userDefault.stringForKey("noticeTime") as String!
            optionsNoticeTime = optionsNoticeTime + ":00"
            let dateFormatter: NSDateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "HH:mm:ss"
            
            var everydayNoticeTime = dateFormatter.dateFromString(optionsNoticeTime) as NSDate!
            
            
            localNotification.fireDate = everydayNoticeTime
            localNotification.timeZone = NSTimeZone.localTimeZone()
            localNotification.repeatInterval = .CalendarUnitDay
            
            localNotification.alertAction = "查看今日运势"
            //localNotification.alertBody = today_info_substr
            localNotification.alertBody = "又是新的一天！快来看看你今天的运势怎么样吧！😆"
            localNotification.soundName = UILocalNotificationDefaultSoundName
            localNotification.applicationIconBadgeNumber = UIApplication.sharedApplication().applicationIconBadgeNumber + 1
            
            UIApplication.sharedApplication().scheduleLocalNotification(localNotification)
            
            
            
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let viewController = storyboard.instantiateViewControllerWithIdentifier("mainView") as UIViewController // Explicit cast is required here.
            viewController.modalTransitionStyle = .CoverVertical
            self.presentViewController(viewController, animated: true, completion: nil)
            println("Saved Data and Back To Main View");
        }
        
        
    }
    
    
    /* 生日键盘设置开始 */
    @IBAction func dateTextInputPressed(sender: UITextField) {
        
        
        //Create the view
        let inputView = UIView(frame: CGRectMake(0, 0, self.view.frame.width, 240))
        
        var datePickerView  : UIDatePicker = UIDatePicker(frame: CGRectMake(0, 40, 0, 0))
        datePickerView.datePickerMode = UIDatePickerMode.Date
        datePickerView.locale = NSLocale(localeIdentifier: "zh_CN")
        
        var dateString = "2000-01-01"
        var df = NSDateFormatter()
        df.dateFormat = "yyyy-MM-dd"
        var date = df.dateFromString(dateString)
        if let unwrappedDate = date {
            datePickerView.setDate(unwrappedDate, animated: false)
        }
        
        inputView.addSubview(datePickerView) // add date picker to UIView
        
        //let doneButton = UIButton(frame: CGRectMake(110, 0, 100, 50))
        let doneButton = UIButton(frame: CGRectMake((self.view.frame.size.width/2) - (100/2), 0, 100, 50))
        doneButton.setTitle("完成", forState: UIControlState.Normal)
        doneButton.setTitle("完成", forState: UIControlState.Highlighted)
        doneButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        doneButton.setTitleColor(UIColor.grayColor(), forState: UIControlState.Highlighted)
        
        inputView.addSubview(doneButton) // add Button to UIView
        
        doneButton.addTarget(self, action: "doneButton:", forControlEvents: UIControlEvents.TouchUpInside) // set button click event
        
        sender.inputView = inputView

        datePickerView.addTarget(self, action: Selector("handleDatePicker:"), forControlEvents: UIControlEvents.ValueChanged)
        
        handleDatePicker(datePickerView) // Set the date on start.
        
    }
    
    func handleDatePicker(sender: UIDatePicker) {
        var dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        datePicker.text = dateFormatter.stringFromDate(sender.date)
    }

    
    func doneButton(sender:UIButton)
    {
        datePicker.resignFirstResponder() // To resign the inputView on clicking done.
    }
    /* 生日键盘设置结束 */
    
    
    func notificationsOptions()  {
        noticeTimePicker.hidden = true;
        noticeTimePicker.datePickerMode = UIDatePickerMode.Time
        noticeTimePicker.locale = NSLocale(localeIdentifier: "zh_CN")
        
        
        //     you may add arbitrary key-value pairs to this dictionary.
        //     However, the keys and values must be valid property-list types
        //     if any are not, an exception is raised.
        // localNotification.userInfo = [NSObject : AnyObject]?
    }
    
    
    func noticeToggleSwitch(){
        var userDefault = NSUserDefaults.standardUserDefaults()
        if noticeSwitch.on{
            noticeTimePicker.userInteractionEnabled = true
            noticeTimePicker.hidden = false
            userDefault.setObject("ON", forKey: "noticeSwitch")
            userDefault.synchronize()
            println("Enable Notification!")
        } else {
            UIApplication.sharedApplication().cancelAllLocalNotifications()
            //localNotification.fireDate = NSDate(timeIntervalSinceNow: 999999999999)   // will never be fired
            noticeTimePicker.userInteractionEnabled = false
            noticeTimePicker.hidden = true
            userDefault.setObject("OFF", forKey: "noticeSwitch")
            userDefault.synchronize()
            println("Disable Notification!")
        }
    }

    
    
    
    @IBAction func noticeSwitchPressed(sender: AnyObject) {
        noticeToggleSwitch()
    }
    
    @IBAction func noticeTimeChanged(sender: UIDatePicker) {
        var dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        noticeHiddenTime.text = dateFormatter.stringFromDate(sender.date)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if (self.view.frame.size.height > 600){
            var version = NSBundle.mainBundle().objectForInfoDictionaryKey("CFBundleShortVersionString") as String
            var build = NSBundle.mainBundle().objectForInfoDictionaryKey(kCFBundleVersionKey as NSString) as String
        
            versionLabel.numberOfLines = 0;                               // Enable \n break line
            versionLabel.hidden = false;                                     // Disable Hidden
        
            versionLabel.text = "V " + version + " (Build " + build + ")"
        }else{
            versionLabel.hidden = true
            made_by_arefly.hidden = true
        }
        
        if self.restorationIdentifier == "startView" {
            welcomeLabel.numberOfLines = 0;
            welcomeLabel.text = "欢迎！\n\n让我们一起来看看我们\n每个人最独特的星座运势吧！"
        }
        
        notificationsOptions()
        
        let defaults = NSUserDefaults.standardUserDefaults()
        
        var name = defaults.stringForKey("name") as String!
        var birthday = defaults.stringForKey("birthday") as String!
        var noticeTime = defaults.stringForKey("noticeTime") as String!
        var noticeOnOff = defaults.stringForKey("noticeSwitch") as String!
        
        
        if (name == nil) {
            //DO NOTHING
        }else{
            user_name.text = name
        }
        
        if (birthday == nil) {
            //DO NOTHING
        }else{
            datePicker.text = birthday
        }
        
        if (noticeTime == nil) {
            //DO NOTHING
        }else{
            var df = NSDateFormatter()
            df.dateFormat = "HH:mm"
            var date = df.dateFromString(noticeTime)
            if let unwrappedDate = date {
                noticeTimePicker.setDate(unwrappedDate, animated: false)
            }
        }
        
        if (noticeOnOff == nil) {
            //DO NOTHING
        }else{
            if (noticeOnOff == "ON"){
                noticeSwitch.on = true
                noticeToggleSwitch()
            }
        }
        
        
        
        

  
        
        
    }
    
   
    
    
    
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        self.view.endEditing(true);
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

    
    
    
    
    
}



public extension NSDate {
    func xDays(x:Int) -> NSDate {
        return NSCalendar.currentCalendar().dateByAddingUnit(.CalendarUnitDay, value: x, toDate: self, options: nil)!
    }
    var day:            Int { return NSCalendar.currentCalendar().components(NSCalendarUnit.CalendarUnitDay,           fromDate: self).day           }
    var month:          Int { return NSCalendar.currentCalendar().components(NSCalendarUnit.CalendarUnitMonth,         fromDate: self).month         }
    var year:           Int { return NSCalendar.currentCalendar().components(NSCalendarUnit.CalendarUnitYear,          fromDate: self).year          }
    var fireDate: NSDate    { return NSCalendar.currentCalendar().dateWithEra(1, year: year, month: month, day: day, hour: 7, minute: 0, second: 0, nanosecond: 0)! }
}
