//
//  AddCalendarVC.swift
//  lanShan_Git_1.0
//
//  Created by WuJiLei on 2019/3/11.
//  Copyright © 2019年 OS X. All rights reserved.
//

import UIKit

class AddCalendarVC: UIViewController ,UITextViewDelegate{
    @IBOutlet weak var headImage: UIImageView!
    @IBOutlet weak var titleTF: UITextField!
    @IBOutlet weak var phoneTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var addressTF: UITextField!
    @IBOutlet weak var wechatTF: UITextField!
    @IBOutlet weak var qqTF: UITextField!
    @IBOutlet weak var detailTV: UITextView!
    
    //let detailTV = UITextView()
    let placeholderLab = UILabel()
    var calendarModelList = [AddCalendarModel]()
    var refreshblock : ((_ calendarModelList : [AddCalendarModel])  -> Void)?
    override func viewDidLoad() {
        super.viewDidLoad()
       // phoneTF.keyboardType = .numberPad
       // qqTF.keyboardType = .numberPad
        setUI()
    }
    //UI PART
    func setUI() -> () {
        view.backgroundColor = UIColor.white
        let topNavView = UIView.init(frame: CGRect.init(x: 0, y: statusBarH, width: ScreenW, height: 44))
        view.addSubview(topNavView)
        //返回按钮
        let backBtn = UIButton.init(type: .custom)
        backBtn.frame = CGRect.init(x: 10, y: 2, width: 32, height: 32)
        backBtn.setImage(UIImage.init(named: "back86x86"), for: .normal)
        backBtn.addTarget(self, action: #selector(ClickBack), for: UIControl.Event.touchUpInside)
        topNavView.addSubview(backBtn)
        //保存按钮
        let SaveBtn = UIButton.init(type: .custom)
        SaveBtn.frame = CGRect.init(x: ScreenW - 77, y: 9, width: 60, height: 26)
        SaveBtn.setTitle("保存", for: .normal)
        SaveBtn.layer.cornerRadius = 4
        SaveBtn.clipsToBounds = true
        SaveBtn.backgroundColor = UIColor.colorWithHexString(color: "0x6bdbb1")
        SaveBtn.addTarget(self, action: #selector(ClickSave), for: UIControl.Event.touchUpInside)
        topNavView.addSubview(SaveBtn)
        //设置头像阴影
        headImage.layer.shadowColor = UIColor.init(red: 92/225, green: 221/225, blue: 169/225, alpha: 1).cgColor
        headImage.layer.shadowOffset = CGSize(width: 0, height: 1)
        headImage.layer.shadowOpacity = 0.45
        headImage.layer.shadowRadius = 10
        //详情
        detailTV.frame = CGRect.init(x: 16, y: statusBarH + 44 + 65, width: ScreenW - 32, height: 40)
        detailTV.backgroundColor = UIColor.white
        detailTV.delegate = self
        detailTV.font = UIFont.systemFont(ofSize: 15)
        view.addSubview(detailTV)
        placeholderLab.frame = CGRect.init(x: 3, y: 4, width: 100, height: 20)
        placeholderLab.textAlignment = NSTextAlignment.left
        placeholderLab.textColor = UIColor.lightGray//.colorWithHexString(color: "0xc7c7cb")
        placeholderLab.text = "请输入备注"
        detailTV.addSubview(placeholderLab)
        
        
       
    }
    @objc func ClickSave()  {
        if titleTF.text == ""{//titleTF.text == "" ||
            print("请输入姓名")
            let alertController = UIAlertController(title: "请输入姓名",
                                                    message: nil, preferredStyle: .alert)
            //显示提示框
            self.present(alertController, animated: true, completion: nil)
            //两秒钟后自动消失
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
                self.presentedViewController?.dismiss(animated: false, completion: nil)
            }
            return
        }
        let model = AddCalendarModel()
        model.title = titleTF.text!
        model.details = detailTV.text!
        model.email = emailTF.text!
        model.phoneNum = phoneTF.text!
        model.address = addressTF.text!
        model.qq = qqTF.text!
        model.wechat = wechatTF.text!
//        //日期
//        let date = Date()
//        let formatt = DateFormatter()
//        formatt.dateFormat = "YYY-MM-dd"
//        let  newDate = formatt.string(from: date)
//        model.CreatDate = newDate
        calendarModelList = [model] + calendarModelList
        let calendarPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).last! +  "/calendar.array"
        print("calendarPath=\(calendarPath)")
        //先看缓存
        NSKeyedArchiver.archiveRootObject(calendarModelList, toFile: calendarPath)
        if self.refreshblock != nil{
            self.refreshblock!(self.calendarModelList)
        }
        self.ClickBack()
        
    }
    //返回
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
