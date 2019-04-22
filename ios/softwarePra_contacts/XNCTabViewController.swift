//
//  XNCTabViewController.swift
//  softwarePra_contacts
//
//  Created by 03 on 2019/4/17.
//  Copyright © 2019 03. All rights reserved.
//

import UIKit
//tabbar总控制器
let itemNameArray:[String] = ["contact","my"]

let itemNameSelectArray:[String] = ["contact_select","my_select"]
class XNCTabViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBar.isTranslucent = false
        self.tabBar.barTintColor = UIColor.white
        self.tabBar.tintColor = UIColor(red: 85/225, green: 214/225, blue: 162/225, alpha: 1)
        var items:[UITabBarItem] = self.tabBar.items as! [UITabBarItem]
        for i in 0...(items.count - 1){
            //显示原图片
            items[i].image = UIImage.init(named: itemNameArray[i])?.withRenderingMode(.alwaysOriginal)
            items[i].selectedImage = UIImage.init(named: itemNameSelectArray[i])?.withRenderingMode(.alwaysOriginal)
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
