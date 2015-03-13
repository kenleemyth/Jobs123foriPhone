//
//  ViewController.swift
//  jobs123
//
//  Created by liyong on 15/2/21.
//  Copyright (c) 2015 Myth. All rights reserved.
//

import UIKit

class ViewController: UIViewController , UITableViewDataSource ,UITableViewDelegate,HttpProtocol{

    @IBOutlet weak var areabtn: UIButton!
    @IBOutlet weak var tv: UITableView!
    var jobsinfo:NSArray=NSArray()
    var ehttp:HttpController = HttpController()

    //areabtn.titleLabel?.text=self.areadata["name"] as? String
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ehttp.delegat = self
        ehttp.OnSearch("http://jobs123.cn/api.php/Index/getJzInfo")
        
   }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        //var areaC:AreaChannelController=segue.destinationViewController as AreaChannelController
        //areaC.AreaData=self.areadata;
        //println(areadata)
    }
       
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return jobsinfo.count
    }
    
    // Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
    // Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        
        let cell = UITableViewCell(style: UITableViewCellStyle.Subtitle,
            reuseIdentifier: "areacell")
        
        let rowData:NSDictionary = self.jobsinfo[indexPath.row] as NSDictionary
        
        // cell.textLabel?.text
        cell.textLabel?.text = rowData["name"] as? String
        
        
        
        var outputFormat = NSDateFormatter()
        let time:NSString = rowData["creattime"] as NSString
        //格式化规则
        outputFormat.dateFormat = "yyyy年MM月dd日"
        //定义时区
        outputFormat.locale = NSLocale(localeIdentifier: "shanghai")
        //发布时间
        let pubTime = NSDate(timeIntervalSince1970:time.doubleValue)
        //println(outputFormat.stringFromDate(pubTime))
        
        cell.detailTextLabel?.text = "发布时间：" + outputFormat.stringFromDate(pubTime)
        //println(rowData["name"])
        return cell
        
    }

    
    func didRecieveResults(results: NSDictionary) {
        //self.areadata = results["city"] as NSArray
        self.jobsinfo = results["JzInfo"] as NSArray
        //println(self.AreaData)
        self.tv.reloadData()

    }
}

