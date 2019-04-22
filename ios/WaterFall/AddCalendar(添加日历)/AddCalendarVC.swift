//
//  AddCalendarVC.swift
//  lanShan_Git_1.0
//
//  Created by WuJiLei on 2019/3/11.
//  Copyright © 2019年 OS X. All rights reserved.
//

import UIKit

class AddCalendarVC: UIViewController ,UITextViewDelegate{
    let  titleTF = UITextField()
    //详情
    let detailsTV = UITextView()
    let placeholderLab = UILabel()
    var calendarModelList = [AddCalendarModel]()
    var refreshblock : ((_ calendarModelList : [AddCalendarModel])  -> Void)?
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
        backBtn.setImage(UIImage.init(named: "unfold"), for: .normal)
        backBtn.addTarget(self, action: #selector(ClickBack), for: UIControl.Event.touchUpInside)
        topNavView.addSubview(backBtn)
        
        let SaveBtn = UIButton.init(type: .custom)
        SaveBtn.frame = CGRect.init(x: ScreenW - 77, y: 9, width: 60, height: 26)
        SaveBtn.setTitle("发布", for: .normal)
        SaveBtn.layer.cornerRadius = 4
        SaveBtn.clipsToBounds = true
        SaveBtn.backgroundColor = UIColor.colorWithHexString(color: "0x6bdbb1")
        SaveBtn.addTarget(self, action: #selector(ClickSave), for: UIControl.Event.touchUpInside)
        topNavView.addSubview(SaveBtn)
        //标题
        titleTF.frame = CGRect.init(x: 16, y: statusBarH + 44 + 10, width: ScreenW - 32, height: 40)
        titleTF.placeholder = "请输入标题"
        view.addSubview(titleTF)
        let line  = UIView()
        line.frame = CGRect.init(x: 16, y: statusBarH + 44 + 51, width: ScreenW - 32, height: 1)
        line.backgroundColor = GRAY_BACKGROUND_COLOR
        view.addSubview(line)
        //详情
        detailsTV.frame = CGRect.init(x: 16, y: statusBarH + 44 + 65, width: ScreenW - 32, height: 400)
        detailsTV.backgroundColor = UIColor.white//GRAY_BACKGROUND_COLOR
        detailsTV.layer.borderWidth = 0.8
        detailsTV.layer.borderColor = UIColor.gray.cgColor
        detailsTV.delegate = self
        detailsTV.font = UIFont.systemFont(ofSize: 15)
        view.addSubview(detailsTV)
        
        placeholderLab.frame = CGRect.init(x: 3, y: 4, width: 100, height: 20)
        placeholderLab.textAlignment = NSTextAlignment.left
        placeholderLab.textColor = UIColor.colorWithHexString(color: "0xc7c7cb")
        placeholderLab.text = "请输入正文"
        detailsTV.addSubview(placeholderLab)
       
    }
    @objc func ClickSave()  {
        if titleTF.text == "" || detailsTV.text == "" {
            print("请输入内容")
            return
        }
        let model = AddCalendarModel()
        model.title = titleTF.text!
        model.details = detailsTV.text!
        //日期
        let date = Date()
        let formatt = DateFormatter()
        formatt.dateFormat = "YYY-MM-dd"
        let  newDate = formatt.string(from: date)
        model.CreatDate = newDate
        calendarModelList = [model] + calendarModelList
        //
        let calendarPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).last! +  "/calendar.array"
        print("calendarPath=\(calendarPath)")
        //先看缓存
        NSKeyedArchiver.archiveRootObject(calendarModelList, toFile: calendarPath)
        if self.refreshblock != nil{
            self.refreshblock!(self.calendarModelList)
        }
        self.ClickBack()
        
    }
    @objc func ClickBack()  {
        self.dismiss(animated: false, completion: nil)
    }
    func textViewDidChange(_ textView: UITextView) {
        if textView.text == "" {
            self.placeholderLab.isHidden = false
        }else{
            self.placeholderLab.isHidden = true
        }
    }
}
