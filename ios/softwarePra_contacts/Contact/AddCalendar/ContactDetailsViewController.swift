//
//  ContactDetailsViewController.swift
//  softwarePra_contacts
//
//  Created by 03 on 2019/4/19.
//  Copyright © 2019 03. All rights reserved.
//

import UIKit

class ContactDetailsViewController: UIViewController,UITextViewDelegate{
    var deteleblock : (()  -> Void)?
    @IBOutlet weak var bgImageView: UIImageView!
    @IBOutlet weak var titileTF: UILabel!
    @IBOutlet weak var wechatTF: UILabel!
    @IBOutlet weak var addressTF: UILabel!
    @IBOutlet weak var emailTF: UILabel!
    
    @IBOutlet weak var headImage: UIButton!
    @IBOutlet weak var phoneTF: UILabel!
    @IBOutlet weak var detailsTV: UITextView!
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
        backBtn.frame = CGRect.init(x: 10, y: 2, width: 32, height: 32)
        backBtn.setImage(UIImage.init(named: "back86x86"), for: .normal)
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
        bgImageView.layer.shadowColor = UIColor.init(red: 129/225, green: 129/225, blue: 129/225, alpha: 1).cgColor
        bgImageView.layer.shadowOffset = CGSize(width: 0, height: 1)
        bgImageView.layer.shadowOpacity = 0.45
        bgImageView.layer.shadowRadius = 10
        
        detailsTV.layer.shadowColor = UIColor.init(red: 129/225, green: 129/225, blue: 129/225, alpha: 1).cgColor
        detailsTV.layer.shadowOffset = CGSize(width: 0, height: 1)
        detailsTV.layer.shadowOpacity = 0.45
        detailsTV.layer.shadowRadius = 10
        
        phoneTF.layer.shadowColor = UIColor.init(red: 129/225, green: 129/225, blue: 129/225, alpha: 1).cgColor
        phoneTF.layer.shadowOffset = CGSize(width: 0, height: 1)
        phoneTF.layer.shadowOpacity = 0.45
        phoneTF.layer.shadowRadius = 10
        
        emailTF.layer.shadowColor = UIColor.init(red: 129/225, green: 129/225, blue: 129/225, alpha: 1).cgColor
        emailTF.layer.shadowOffset = CGSize(width: 0, height: 1)
        emailTF.layer.shadowOpacity = 0.45
        emailTF.layer.shadowRadius = 10
        
        addressTF.layer.shadowColor = UIColor.init(red: 129/225, green: 129/225, blue: 129/225, alpha: 1).cgColor
        addressTF.layer.shadowOffset = CGSize(width: 0, height: 1)
        addressTF.layer.shadowOpacity = 0.45
        addressTF.layer.shadowRadius = 10
        
        wechatTF.layer.shadowColor = UIColor.init(red: 129/225, green: 129/225, blue: 129/225, alpha: 1).cgColor
        wechatTF.layer.shadowOffset = CGSize(width: 0, height: 1)
        wechatTF.layer.shadowOpacity = 0.45
        wechatTF.layer.shadowRadius = 10
        
        detailsTV.text = calendarModel.details
        titileTF.text = calendarModel.title
        phoneTF.text = calendarModel.phoneNum
        addressTF.text = calendarModel.address
        emailTF.text = calendarModel.email
        wechatTF.text = calendarModel.wechat
        
        let timeLab = UILabel()
        timeLab.frame = CGRect.init(x: 16, y: navStatusBarH + 40, width: ScreenW - 30, height: 16)
        timeLab.textAlignment = NSTextAlignment.left
        let CreatDateArray =  calendarModel.CreatDate.components(separatedBy: "-")
        timeLab.text = CreatDateArray[0] + "年" + CreatDateArray[1] + "月" +  CreatDateArray[2] + "日"
        timeLab.textColor = UIColor.colorWithHexString(color: "0x2b2b2b", alpha: 0.4)
        timeLab.font = UIFont.systemFont(ofSize: 14)
        view.addSubview(timeLab)
        
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
