//
//  AddCalendarModel.swift
//  lanShan_Git_1.0
//
//  Created by WuJiLei on 2019/3/11.
//  Copyright © 2019年 OS X. All rights reserved.
//

import UIKit

class AddCalendarModel: NSObject,NSCoding {
    var title = ""
    var details = ""
    var CreatDate = ""
    override init() {
        
    }
    //编码
    func encode(with aCoder: NSCoder) {
        aCoder.encode(title, forKey: "title")
        aCoder.encode(details, forKey: "details")
        aCoder.encode(CreatDate, forKey: "CreatDate")
        
        
    }
    
    //解码
    required init?(coder aDecoder: NSCoder) {
        super.init()
        title = aDecoder.decodeObject(forKey: "title") as! String
        details = aDecoder.decodeObject(forKey: "details") as! String
        CreatDate = aDecoder.decodeObject(forKey: "CreatDate") as! String
        
        
        
    }
    
}
