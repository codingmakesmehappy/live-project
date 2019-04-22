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
    @IBOutlet weak var bgImageView: UIImageView!
    
//    let  titleLab = UITextField()
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
        //详情 不要显示空格换行
//        detailsTV.frame = CGRect.init(x: 16, y: navStatusBarH + 65, width: ScreenW - 32, height: ScreenH - navStatusBarH - 55)
//        detailsTV.backgroundColor = UIColor.white
//        detailsTV.delegate = self
//        detailsTV.textColor = UIColor.colorWithHexString(color: "0x2b2b2b", alpha: 0.6)
//        detailsTV.text = calendarModel.details
//        detailsTV.font = UIFont.systemFont(ofSize: 15)
//        view.addSubview(detailsTV)
        
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
