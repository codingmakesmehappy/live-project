//
//  searchCityPCH.swift
//  searchCity
//
//  Created by WuJiLei on 2019/2/18.
//  Copyright © 2019年 com.znxunzhi.AJiaMiddleTeacher. All rights reserved.
//

import UIKit

public let ScreenW = UIScreen.main.bounds.size.width
public let ScreenH = UIScreen.main.bounds.size.height

public let ScreenH_safe = iPhoneX == true  ? ScreenH - 34 : ScreenH

public let IS_IPHONE_5_LESS = ScreenH <= 568 ? true : false
public let IS_IPHONE_4 = ScreenH < 568.0 ? true : false
public let IS_IPHONE_5 = ScreenH == 568.0 ? true : false
public let IS_IPHONE_6 = ScreenH == 667.0 ? true : false
public let IS_IPHONE_6P = ScreenH == 736.0 ? true : false
public var iPhoneX : Bool = (UIScreen.main.bounds.width == 375.0 && UIScreen.main.bounds.height == 812.0) || (UIScreen.main.bounds.width == 414.0 && UIScreen.main.bounds.height == 896.0) || (UIScreen.main.bounds.width == 375.0 && UIScreen.main.bounds.height == 896.0)  ? true : false  //x  xsM  xr  的尺寸

public let tabBarH : CGFloat = UIScreen.main.bounds.height == 812.0  ? 83.00 : 49.00
//var navStatusBarH_heng : CGFloat = iPhoneX == true ? 32 : 44  //32
public let statusBarH : CGFloat = iPhoneX == true  ? 44.00 : 20.00
public let navStatusBarH : CGFloat = iPhoneX == true  ? 88.00 : 64.00
public let navBarH : CGFloat = iPhoneX == true  ? 44.00 : 44.00




let GRAY_BACKGROUND_COLOR = UIColor(red: 242/255.0, green: 242/255.0, blue: 242/255.0, alpha: 1.0)//灰底色
let BLUE_BASE_COLOR = UIColor(red: 1/255.0, green: 175/255.0, blue: 229/255.0, alpha: 1.0)//灰底色

let recoreCityPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).last! + "/recoreCity.dict"


