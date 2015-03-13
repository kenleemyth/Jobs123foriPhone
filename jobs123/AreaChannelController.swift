//
//  AreaChannelController.swift
//  jobs123
//
//  Created by liyong on 15/2/21.
//  Copyright (c) 2015 Myth. All rights reserved.
//

import UIKit

protocol AreaProtocol{
    func onChangeArea(Area_id:String,Area_name:String)
}

class AreaChannelController: UIViewController ,UITableViewDataSource,UITableViewDelegate,HttpProtocol{
    
    @IBOutlet weak var areatv: UITableView!
    var ehttp:HttpController = HttpController()
    var AreaData:NSArray=NSArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ehttp.delegat=self
        ehttp.OnSearch("http://www.jobs123.cn/api.php/Index/getAllCity")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
        return AreaData.count
    }
    

    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        
        let cell = UITableViewCell(style: UITableViewCellStyle.Subtitle,
            reuseIdentifier: "areacell")

        let rowData:NSDictionary = self.AreaData[indexPath.row] as NSDictionary
        
       // cell.textLabel?.text
        cell.textLabel?.text = rowData["name"] as? String
        //println(rowData["name"])
        return cell
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        
        
         let rowData:NSDictionary = self.AreaData[indexPath.row] as NSDictionary
        //get infomation back
        let area_id:AnyObject? = rowData["id"] as AnyObject?
        let area_name:AnyObject? = rowData["name"] as AnyObject?
        
        
        //点击后返回
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    func didRecieveResults(results:NSDictionary){
        
        self.AreaData = results["city"] as NSArray
        //println(self.AreaData)
        self.areatv.reloadData()
    }


}
