//
//  ViewController.swift
//  RandomEating
//
//  Created by LS on 14/10/8.
//  Copyright (c) 2014年 LS. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var preButton :UIButton = UIButton.buttonWithType(UIButtonType.Custom) as UIButton
    var eatLabel: UILabel = UILabel(frame: CGRectMake(10, 30, 300, 50))
    var randomButton : UIButton = UIButton.buttonWithType(UIButtonType.Custom) as UIButton
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        preButton.frame = CGRectMake(50, 200, 100, 100)
        preButton.setTitle("添加", forState: UIControlState.Normal)
        view.addSubview(preButton)
        preButton.backgroundColor = UIColor.grayColor()
        
        randomButton.frame = CGRectMake(160, 200, 100, 100)
        randomButton.setTitle("开始随机", forState: UIControlState.Normal)
        view.addSubview(randomButton)
        randomButton.backgroundColor = UIColor.grayColor()
        
        eatLabel.backgroundColor = UIColor.grayColor()
        eatLabel.textAlignment = NSTextAlignment.Center
        view.addSubview(eatLabel)
        
        var viewModel = ViewControllerModel()
        
        RACObserve(viewModel, "foodStr").subscribeNext { (next:AnyObject!) -> Void in
            self.eatLabel.text = next as? String
        }
        
        randomButton.rac_command = viewModel.randomCommand
        
        preButton.rac_command = RACCommand(signalBlock: { (next:AnyObject!) -> RACSignal! in
            var addVC = AddViewController()
            self.presentViewController(addVC, animated: true, completion: nil)
            return RACSignal.empty()
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

