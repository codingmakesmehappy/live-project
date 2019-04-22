//
//  XNCRegisterViewController.swift
//  softwarePra_contacts
//
//  Created by 03 on 2019/4/17.
//  Copyright © 2019 03. All rights reserved.
//

import UIKit
//注册界面
class XNCRegisterViewController: UIViewController,UITextFieldDelegate{
    @IBOutlet weak var phoneNumTextField: UITextField!
    @IBOutlet weak var selectButton: UIButton!
    @IBOutlet weak var pass2TextField: UITextField!
    @IBOutlet weak var pass1TextField: UITextField!
    @IBOutlet weak var ValidateButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        //UI PART
        //设置按钮阴影
        ValidateButton.layer.shadowColor = UIColor.init(red: 92/225, green: 221/225, blue: 169/225, alpha: 1).cgColor
        ValidateButton.layer.shadowOffset = CGSize(width: 0, height: 0)
        ValidateButton.layer.shadowOpacity = 0.45
        ValidateButton.layer.shadowRadius = 6
        ValidateButton.clipsToBounds = false
        //设置密码隐藏
        pass1TextField.isSecureTextEntry=true
        pass2TextField.isSecureTextEntry=true
        //自定义返回按钮
        let backButton = UIButton(type: UIButton.ButtonType.system)
        backButton.setBackgroundImage(#imageLiteral(resourceName: "back86x86"), for: .normal)
        backButton.frame = CGRect(x: 25, y: 44, width: 29, height: 29)
        //ACTION PART
        selectButton.addTarget(self, action: #selector(tapped(button:)), for: UIControl.Event.touchUpInside)
        backButton.addTarget(self, action: #selector(back), for: UIControl.Event.touchUpInside)
        self.view.addSubview(backButton)
        ValidateButton.addTarget(self, action: #selector(register), for: .touchUpOutside)
    }
    
    @objc func back(sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    @objc func register(sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
        //注册动作
    }
    @objc func tapped(button:UIButton){
        selectButton.isSelected = (!selectButton.isSelected)
        if (selectButton.isSelected) {
            //没选中的操作
            selectButton.setImage(UIImage(named: "xuanzhong48x48"), for: .normal)
        }
        else{
            //选中后的操作
            selectButton.setImage(UIImage(named: "round"), for: .normal)
        }
    }
    //收回键盘
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        pass1TextField.resignFirstResponder()
        pass2TextField.resignFirstResponder()
        phoneNumTextField.resignFirstResponder()
        return true
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        pass1TextField.resignFirstResponder()
        pass2TextField.resignFirstResponder()
        phoneNumTextField.resignFirstResponder()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
