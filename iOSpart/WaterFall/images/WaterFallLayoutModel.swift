//
//  WaterFallLayoutModel.swift
//  lanShan_Git_1.0
//
//  Created by WuJiLei on 2019/2/25.
//  Copyright © 2019年 OS X. All rights reserved.
//

import UIKit

class WaterFallLayoutModel: NSObject,NSCoding {
    var imageName  = ""
    var imageSizeW  = ""
    var imageSizeH = ""
    override init() {
        
    }
    //编码
    func encode(with aCoder: NSCoder) {
        aCoder.encode(imageName, forKey: "imageName")
        aCoder.encode(imageSizeW, forKey: "imageSizeW")
        aCoder.encode(imageSizeH, forKey: "imageSizeH")
        
        
    }
    
    //解码
    required init?(coder aDecoder: NSCoder) {
        super.init()
        imageName = aDecoder.decodeObject(forKey: "imageName") as! String
        imageSizeW = aDecoder.decodeObject(forKey: "imageSizeW") as! String
        imageSizeH = aDecoder.decodeObject(forKey: "imageSizeH") as! String
       
        
        
    }
    /*
     model.imageSizeW = String.init(format: "%.2f", image!.size.width)
     model.imageSizeH = String.init(format: "%.2f", image!.size.height)
     */
}
