//
//  CalendarCell.swift
//  lanShan_Git_1.0
//
//  Created by WuJiLei on 2019/3/11.
//  Copyright © 2019年 OS X. All rights reserved.
//

import UIKit

class CalendarCell: UITableViewCell {
    let dayLab = UILabel()
    let monthLab = UILabel()
    let titleLab = UILabel()
    let detailsLab = UILabel()
    let wechatLab = UILabel()
    let addressLab = UILabel()
    let phoneLab = UILabel()
    let emailLab = UILabel()
    let headImage = UIImage()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.addSub()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func addSub() -> (){
        self.contentView.backgroundColor = GRAY_BACKGROUND_COLOR
        //109
        let whiteView = UIView()
        whiteView.frame = CGRect.init(x: 10, y:7.5, width: ScreenW - 20, height:120)
        whiteView.backgroundColor = UIColor.white
        whiteView.layer.shadowColor = UIColor.gray.cgColor
        whiteView.layer.shadowRadius = 5
        whiteView.layer.shadowOffset = CGSize(width: -4, height: 4)
        whiteView.layer.shadowOpacity = 0.45
        self.contentView.addSubview(whiteView)
        //日
        dayLab.frame = CGRect.init(x: 16, y:10, width: 40, height:35)
        dayLab.textAlignment = NSTextAlignment.left
        dayLab.text = ""
        dayLab.textColor = UIColor.colorWithHexString(color: "#000000")
        dayLab.font = UIFont.init(name: "Helvetica-Bold", size: 17)
        whiteView.addSubview(dayLab)
        //月
        monthLab.frame = CGRect.init(x: 16, y:35, width: 40, height:35)
        monthLab.textAlignment = NSTextAlignment.left
        monthLab.text = ""
        monthLab.textColor = UIColor.colorWithHexString(color: "#000000")
        monthLab.font = UIFont.systemFont(ofSize: 15)
        whiteView.addSubview(monthLab)
        
        let point1 = UIImageView(image: UIImage(named: "奖品"))
        point1.frame = CGRect(x: 85 , y: 20, width: 16, height: 16)
        whiteView.addSubview(point1)
        let point2 = UIImageView(image: UIImage(named: "个人信息二维码 (1)"))
        point2.frame = CGRect(x: 85 , y: 49, width: 16, height: 16)
        whiteView.addSubview(point2)
        let point3 = UIImageView(image: UIImage(named: "充值人数"))
        point3.frame = CGRect(x: 85 , y:82 , width: 16, height: 16)
        whiteView.addSubview(point3)
        //姓名
        titleLab.frame = CGRect.init(x: 105, y:10, width: ScreenW - 100, height:35)
        titleLab.textAlignment = NSTextAlignment.left
        titleLab.text = ""
        titleLab.textColor = UIColor.colorWithHexString(color: "#000000")
        titleLab.font = UIFont.systemFont(ofSize: 17)
        whiteView.addSubview(titleLab)
        //电话
        addressLab.frame = CGRect.init(x: 105, y:40, width: ScreenW - 100, height:35)
        addressLab.textAlignment = NSTextAlignment.left
        addressLab.text = ""
        addressLab.textColor =  UIColor.colorWithHexString(color: "0x2b2b2b", alpha: 0.4)
        addressLab.font = UIFont.systemFont(ofSize: 15)
        whiteView.addSubview(addressLab)
        //简介
        detailsLab.frame = CGRect.init(x: 105, y:72, width: ScreenW - 100, height:35)
        detailsLab.textAlignment = NSTextAlignment.left
        detailsLab.text = ""
        detailsLab.textColor =  UIColor.colorWithHexString(color: "0x2b2b2b", alpha: 0.4)
        detailsLab.font = UIFont.systemFont(ofSize: 15)
        detailsLab.numberOfLines = 2
        whiteView.addSubview(detailsLab)
        
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
