//
//  ViewController.swift
//  softwarePra_contacts
//
//  Created by 03 on 2019/4/17.
//  Copyright © 2019 03. All rights reserved.
//

import UIKit
//登录界面
class ViewController: UIViewController {
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var headImage: UIImageView!
    @IBOutlet weak var accountTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        //UI part
        passwordTextField.isSecureTextEntry=true;
        //设置头像阴影
        headImage.layer.shadowColor = UIColor.init(red: 92/225, green: 221/225, blue: 169/225, alpha: 1).cgColor
        headImage.layer.shadowOffset = CGSize(width: 0, height: 1)
        headImage.layer.shadowOpacity = 0.45
        headImage.layer.shadowRadius = 10
        //设置按钮阴影
        loginButton.layer.shadowColor = UIColor.init(red: 92/225, green: 221/225, blue: 169/225, alpha: 1).cgColor
        loginButton.layer.shadowOffset = CGSize(width: 0, height: 0)
        loginButton.layer.shadowOpacity = 0.45
        loginButton.layer.shadowRadius = 6
        loginButton.clipsToBounds = false
        //设置选中button颜色
        registerButton.setTitleColor(UIColor(red: 85/225, green: 214/225, blue: 162/225, alpha: 1), for: UIControl.State.highlighted)
        registerButton.setTitleColor(UIColor(red: 85/225, green: 214/225, blue: 162/225, alpha: 1), for: UIControl.State.focused)
        
        //ACTION PART
        //loginButton.addTarget(self, action: #selector(loginAction), for: .touchUpInside)
    }
    //收回键盘
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        accountTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        return true
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        accountTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
    }
    //连接数据库
    @objc func loginAction(){
        if(accountTextField.text == "" || passwordTextField.text == ""){
            let alertController = UIAlertController(
                title: "账号密码不能为空!",
                message: nil,
                preferredStyle: .alert)
            //显示提示框
            self.present(alertController, animated: true, completion: nil)
            //两秒钟后自动消失
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
                self.presentedViewController?.dismiss(animated: false, completion: nil)
            }
        }
        else{
            //请求网络
            // 1、创建URL对象；
            let url:URL! = URL(string:"http://35.196.50.82:8081/login/checkpwd");
            // 2、创建Request对象
            // url: 请求路径
            // cachePolicy: 缓存协议
            // timeoutInterval: 网络请求超时时间(单位：秒)
            var urlRequest:URLRequest = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10)
            // 3、设置请求方式为POST，默认是GET
            urlRequest.httpMethod = "POST"
            // 4、设置参数
            let jsonString = "userid=" + accountTextField.text! + "&userpwd=" + passwordTextField.text!
            let jsonData = jsonString.data(using: String.Encoding.utf8, allowLossyConversion: false) ?? Data()
            urlRequest.httpBody = jsonData
            // 5、响应对象
            var response:URLResponse?
            
            // 6、发出请求
            do {
                let received =  try NSURLConnection.sendSynchronousRequest(urlRequest, returning: &response)
                let dic = try JSONSerialization.jsonObject(with: received, options: JSONSerialization.ReadingOptions.allowFragments) as! NSDictionary
                let code = dic["code"] as! Int  //code为返回Json的状态码！！！很很重要哟
                if(code == 501)
                {
                    let alertController = UIAlertController(title: "用户名或密码错误！账号：12345678910，密码：123456",
                                                            message: nil, preferredStyle: .alert)
                    //显示提示框
                    self.present(alertController, animated: true, completion: nil)
                    //两秒钟后自动消失
                    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
                        self.presentedViewController?.dismiss(animated: false, completion: nil)
                    }
                }
                else if (code == 500)
                {
                    //这里是跳转
//                    let sb = UIStoryboard(name: "Main", bundle:nil)
//                    let vc = sb.instantiateViewController(withIdentifier: "tabbar") as! XNCMainTabBarController
//                    self.present(vc, animated: true, completion: nil)
                }
            }catch  let error {
                print(error.localizedDescription);
            }
        }
    }

}

