//
//  XNCPersonInfoViewController.swift
//  softwarePra_contacts
//
//  Created by 03 on 2019/4/17.
//  Copyright © 2019 03. All rights reserved.
//

import UIKit

class XNCPersonInfoViewController: UIViewController {
    
    @IBOutlet weak var headImage: UIButton!
    @IBOutlet weak var SuggestButton: UIButton!
    @IBOutlet weak var aboutBtn: UIButton!
    @IBOutlet weak var backButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        backButton.addTarget(self, action: #selector(backtomain), for: .touchUpInside)
    }
    @objc func backtomain() {
        //这里是跳转
        let sb = UIStoryboard(name: "Main", bundle:nil)
        let vc = sb.instantiateViewController(withIdentifier: "mainvc") as! ViewController
        self.present(vc, animated: true, completion: nil)
    }
    func setUI() {
        //设置按钮阴影
        headImage.layer.shadowColor = UIColor.lightGray.cgColor
        headImage.layer.shadowOffset = CGSize(width: 0, height: 1)
        headImage.layer.shadowOpacity = 0.45
        headImage.layer.shadowRadius = 10
        
        SuggestButton.layer.shadowColor = UIColor.lightGray.cgColor
        SuggestButton.layer.shadowOffset = CGSize(width: 0, height: 1)
        SuggestButton.layer.shadowOpacity = 0.45
        SuggestButton.layer.shadowRadius = 10
        
        aboutBtn.layer.shadowColor = UIColor.lightGray.cgColor
        aboutBtn.layer.shadowOffset = CGSize(width: 0, height: 1)
        aboutBtn.layer.shadowOpacity = 0.45
        aboutBtn.layer.shadowRadius = 10
        
        backButton.layer.shadowColor = UIColor.init(red: 92/225, green: 221/225, blue: 169/225, alpha: 1).cgColor
        backButton.layer.shadowOffset = CGSize(width: 0, height: 1)
        backButton.layer.shadowOpacity = 0.45
        backButton.layer.shadowRadius = 10
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
