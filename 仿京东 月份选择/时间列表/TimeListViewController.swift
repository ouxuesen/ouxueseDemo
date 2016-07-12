//
//  TimeListViewController.swift
//  仿京东 月份选择
//
//  Created by 欧学森 on 16/6/7.
//  Copyright © 2016年 ouxuesen. All rights reserved.
//

import Foundation

enum Rank: Int {
    case Ace = 1
    case Two, Three, Four, Five, Six, Seven, Eight, Nine, Ten
    case Jack, Queen, King
    func simpleDescription() -> String {
        switch self {
        case .Ace:
            return "ace"
        case .Jack:
            return "jack"
        case .Queen:
            return "queen"
        case .King:
            return "king"
        default:
            return String(self.rawValue)
        }
    }
}
func souce(souce: NSDictionary) -> Void {
    
    
}
class TimeListViewController: UIViewController,UITableViewDelegate {

    override func setNeedsFocusUpdate() {
      
        
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.redColor();
        print(Rank.Ace,Rank.Two,Rank.Jack);
        let size = UIScreen.mainScreen().bounds.size
        let tableView = UITableView.init(frame: CGRectMake(0, 0, size.width, size.height), style: UITableViewStyle.Plain)
        tableView.delegate = self
//        tableView.dataSource = self
        self.view .addSubview(tableView)
    }
//    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
//        <#code#>
//    }tab
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
    }
    
}
