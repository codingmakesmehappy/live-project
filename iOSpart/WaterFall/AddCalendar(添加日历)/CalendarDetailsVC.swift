//
//  CalendarDetailsVC.swift
//  lanShan_Git_1.0
//
//  Created by WuJiLei on 2019/3/11.
//  Copyright © 2019年 OS X. All rights reserved.
//

import UIKit

class CalendarDetailsVC: UIViewController,UITextViewDelegate {
    var deteleblock : (()  -> Void)?
    let  titleLab = UITextField()
    //详情
    let detailsTV = UITextView()
    var calendarModel = AddCalendarModel()
    override func viewDidLoad() {
        super.viewDidLoad()

        setUI()
    }
    func setUI() -> () {
        view.backgroundColor = UIColor.white
        let topNavView = UIView.init(frame: CGRect.init(x: 0, y: statusBarH, width: ScreenW, height: 44))
        view.addSubview(topNavView)
        let backBtn = UIButton.init(type: .custom)
        backBtn.frame = CGRect.init(x: 0, y: 2, width: 50, height: 40)
        backBtn.setImage(UIImage.init(named: "back_gray"), for: .normal)
        backBtn.addTarget(self, action: #selector(ClickBack), for: UIControl.Event.touchUpInside)
        topNavView.addSubview(backBtn)
        
        let MoreBtn = UIButton.init(type: .custom)
        MoreBtn.frame = CGRect.init(x: ScreenW - 77, y: 9, width: 60, height: 26)
        MoreBtn.setTitle("删除", for: .normal)
        MoreBtn.layer.cornerRadius = 4
        MoreBtn.clipsToBounds = true
        MoreBtn.backgroundColor = UIColor.colorWithHexString(color: "0x6bdbb1")
        MoreBtn.addTarget(self, action: #selector(ClickMore), for: UIControl.Event.touchUpInside)
        topNavView.addSubview(MoreBtn)
        //标题
        let titleLab = UILabel()
        titleLab.frame = CGRect.init(x: 16, y: navStatusBarH, width: ScreenW - 30, height: 25)
        titleLab.textAlignment = NSTextAlignment.left
        titleLab.text = calendarModel.title
        titleLab.textColor = UIColor.colorWithHexString(color: "#000000")
        titleLab.font = UIFont.systemFont(ofSize: 17)
        view.addSubview(titleLab)
        
        let timeLab = UILabel()
        timeLab.frame = CGRect.init(x: 16, y: navStatusBarH + 30, width: ScreenW - 30, height: 16)
        timeLab.textAlignment = NSTextAlignment.left
        let CreatDateArray =  calendarModel.CreatDate.components(separatedBy: "-")
        timeLab.text = CreatDateArray[0] + "年" + CreatDateArray[1] + "月" +  CreatDateArray[2] + "日"
        timeLab.textColor = UIColor.colorWithHexString(color: "0x2b2b2b", alpha: 0.4)
        timeLab.font = UIFont.systemFont(ofSize: 13)
        view.addSubview(timeLab)
        //详情 不要显示空格换行
        detailsTV.frame = CGRect.init(x: 16, y: navStatusBarH + 55, width: ScreenW - 32, height: ScreenH - navStatusBarH - 55)
        detailsTV.backgroundColor = UIColor.white
        detailsTV.delegate = self
        detailsTV.textColor = UIColor.colorWithHexString(color: "0x2b2b2b", alpha: 0.6)
        detailsTV.text = calendarModel.details
        detailsTV.font = UIFont.systemFont(ofSize: 15)
        view.addSubview(detailsTV)
        
    }
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        return false
    }
    @objc func ClickMore()  {
        //删除
        if self.deteleblock != nil{
            self.deteleblock!()
        }
        self.dismiss(animated: false, completion: nil)
    }
    @objc func ClickBack()  {
        
        self.dismiss(animated: false, completion: nil)
        
    }
}
