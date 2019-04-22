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
        whiteView.frame = CGRect.init(x: 10, y:7.5, width: ScreenW - 20, height:110)
        whiteView.backgroundColor = UIColor.white
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
      //title
        
        titleLab.frame = CGRect.init(x: 70, y:10, width: ScreenW - 100, height:35)
        titleLab.textAlignment = NSTextAlignment.left
        titleLab.text = ""
        titleLab.textColor = UIColor.colorWithHexString(color: "#000000")
        titleLab.font = UIFont.systemFont(ofSize: 17)
        whiteView.addSubview(titleLab)
        
      //details
        
        detailsLab.frame = CGRect.init(x: 70, y:35, width: ScreenW - 100, height:65)
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
