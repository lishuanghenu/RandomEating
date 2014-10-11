//
//  AddViewController.swift
//  RandomEating
//
//  Created by LS on 14/10/8.
//

import UIKit

class AddViewController: UIViewController {

    var myTable : UITableView = UITableView()
    var addButton: UIButton  = UIButton.buttonWithType(UIButtonType.Custom) as UIButton
    var closeButton: UIButton = UIButton.buttonWithType(UIButtonType.Custom) as UIButton
    var field : UITextField = UITextField()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        field.frame = CGRectMake(50, 20, 100, 30)
        field.backgroundColor = UIColor.grayColor()
        view.addSubview(field)
        
        myTable.frame = CGRectMake(0, 110, self.view.frame.width, self.view.frame.height - 110)
        view .addSubview(myTable)
        
        addButton.frame = CGRectMake(10, 70, self.view.frame.width - 20, 30)
        addButton.setTitle("添加新食物", forState: UIControlState.Normal)
        view .addSubview(addButton)
        addButton.backgroundColor = UIColor.grayColor()
        
        closeButton.frame = CGRectMake(0,20, 30, 30)
        closeButton.backgroundColor = UIColor.redColor()
        view.addSubview(closeButton)
        
        
        closeButton.rac_signalForControlEvents(UIControlEvents.TouchUpInside).subscribeNext { (next:AnyObject!) -> Void in
            self.field.resignFirstResponder()
            self.dismissViewControllerAnimated(true, completion: nil)
        }
        
        var addVM = AddViewModel(table: myTable)
        
        self.field.rac_textSignal() ~> RAC(addVM , "str")

        addButton.rac_command = addVM.racCommand
        myTable.delegate = addVM
        myTable.dataSource = addVM
        
        myTable.rac_signalForSelector("scrollViewDidScroll:", fromProtocol: NSProtocolFromString("UITableViewDelegate")).subscribeNext { (next:AnyObject!) -> Void in
            self.field.resignFirstResponder()
            print("leave")
        }
    
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
