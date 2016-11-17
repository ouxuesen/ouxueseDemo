//
//  ShowNavigationBarViewController.swift
//  仿京东 月份选择
//
//  Created by 欧学森 on 16/4/14.
//  Copyright © 2016年 ouxuesen. All rights reserved.
//

import UIKit

class ShowNavigationBarViewController: UIViewController {
   var fag = false
//    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
//        
//    }
//    
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    override func viewDidLoad() {
        super.viewDidLoad()
         self.view.backgroundColor = UIColor.lightGrayColor()
        // 默认带有一定透明效果，可以使用以下方法去除系统效果
        self.navigationController?.navigationBar.translucent = true
        
        
        // 默认navigationBar是隐藏的
        self.navigationController?.setNavigationBarHidden(fag, animated: true)
        let control = UIControl(frame: CGRectMake(0, 0, 300, 300))
        control.backgroundColor = UIColor.blueColor()
        control.addTarget(self, action: #selector(ShowNavigationBarViewController.touchBtnCLick), forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(control)
        
        // Do any additional setup after loading the view.
    }
    func touchBtnCLick(){
        fag = !fag
        self.navigationController?.setNavigationBarHidden(fag, animated: true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
