//
//  ViewControllerModel.swift
//  RandomEating
//
//  Created by LS on 14/10/9.
//  Copyright (c) 2014年 LS. All rights reserved.
//

import UIKit

class ViewControllerModel: NSObject {
    dynamic var foodStr : String!
    var randomCommand : RACCommand!
    
   override init() {
        super.init()
    randomCommand = RACCommand(signalBlock: { (next:AnyObject!) -> RACSignal! in
            self.randomFood()
            return RACSignal.empty()
        })
    }
    
    
    func randomFood () {
        var dataArray = NSMutableArray(array: NSUserDefaults.standardUserDefaults().arrayForKey("array")!)
        let arrayCount = dataArray.count
        var choiceFood : String = ""
        switch arrayCount {
            case 0 :
                break
            case 1 :
                choiceFood = dataArray.objectAtIndex(0) as String
            default :
                var num = random() % arrayCount
                choiceFood = dataArray.objectAtIndex(num) as String
        }
        self.foodStr = choiceFood
    }
}
