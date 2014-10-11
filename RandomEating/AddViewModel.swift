//
//  AddViewModel.swift
//  RandomEating
//
//  Created by LS on 14/10/8.
//  Copyright (c) 2014年 LS. All rights reserved.
//

import UIKit

class AddViewModel: NSObject,UITableViewDataSource,UITableViewDelegate {
    var tableView : UITableView!
    var dataArray  = NSMutableArray.array()
    var racCommand : RACCommand!
    dynamic var str:String?
    
    init(table:UITableView) {
        super.init()
        self.tableView = table
        
        var defults : NSUserDefaults = NSUserDefaults.standardUserDefaults()
        if  let array = defults.arrayForKey("array") {
            if array.count > 0 {
                dataArray = NSMutableArray(array: defults.arrayForKey("array")!)
            }
        }
        racCommand = RACCommand(signalBlock: { (id:AnyObject!) -> RACSignal! in
            self.addText()
            return RACSignal.empty()
        })
    }
    
    
    func addText () -> Bool {
        var add = false
        if self.str != "" {
            if self.dataArray.count > 0{
                for i in self.dataArray {
                    if self.str == i as? String {
                        add = false
                        break
                    }else{
                        add = true
                    }
                }
            }else{
                add = true
            }
        }
        if add {
            self.addFood(self.str!)
            self.str = ""
            return true
        }
        return false
    }
    
    func addFood(foodStr:String) {
        var defults : NSUserDefaults = NSUserDefaults.standardUserDefaults()
        self.dataArray.addObject(foodStr)
        var temp = NSArray(array:self.dataArray)
        defults.setValue(temp, forKey: "array")
        self.tableView.reloadData()
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell : UITableViewCell? = tableView.dequeueReusableCellWithIdentifier("CELL") as? UITableViewCell
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.Value1, reuseIdentifier: "CELL")
        }
        cell!.textLabel!.text = dataArray[indexPath.row] as? String
        return cell!
    }
    
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCellEditingStyle.Delete {
            var tempArray = self.dataArray
            tempArray.removeObjectAtIndex(indexPath.row)
            self.dataArray = tempArray
            var defaultsArray = NSArray(array: tempArray)
            NSUserDefaults.standardUserDefaults().setValue(defaultsArray, forKey: "array")
            self.tableView.reloadData()
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if dataArray.count != 0 {
            return dataArray.count
        }else{
            return 0
        }
    }
}
