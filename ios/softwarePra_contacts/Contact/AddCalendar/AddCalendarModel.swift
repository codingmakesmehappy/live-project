//
//  AddCalendarModel.swift
//  lanShan_Git_1.0
//
//  Created by WuJiLei on 2019/3/11.
//  Copyright © 2019年 OS X. All rights reserved.
//

import UIKit

class AddCalendarModel: NSObject,NSCoding {
    
    var title = ""//姓名
    var details = ""//个人简介
    var email = ""//邮箱
    var phoneNum = ""//电话号码
    var wechat = ""//微信
    var address = ""//地址
    var CreatDate = ""
    
    override init() {
        
    }
    //编码
    func encode(with aCoder: NSCoder) {
        aCoder.encode(title, forKey: "title")
        aCoder.encode(details, forKey: "details")
        aCoder.encode(email, forKey: "email")
        aCoder.encode(wechat, forKey: "wechat")
        aCoder.encode(address, forKey: "address")
        aCoder.encode(phoneNum, forKey: "phoneNum")
        aCoder.encode(CreatDate, forKey: "CreatDate")
        
        
    }
    
    //解码
    required init?(coder aDecoder: NSCoder) {
        super.init()
        title = aDecoder.decodeObject(forKey: "title") as! String
        details = aDecoder.decodeObject(forKey: "details") as! String
        phoneNum = aDecoder.decodeObject(forKey: "phoneNum") as! String
        email = aDecoder.decodeObject(forKey: "email") as! String
        address = aDecoder.decodeObject(forKey: "address") as! String
        wechat = aDecoder.decodeObject(forKey: "wechat") as! String
        CreatDate = aDecoder.decodeObject(forKey: "CreatDate") as! String
        
    }
    
}
