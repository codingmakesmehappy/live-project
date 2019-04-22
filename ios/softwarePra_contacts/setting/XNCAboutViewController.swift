//
//  XNCAboutViewController.swift
//  softwarePra_contacts
//
//  Created by 03 on 2019/4/18.
//  Copyright © 2019 03. All rights reserved.
//

import UIKit

class XNCAboutViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let backButton = UIButton(type: UIButton.ButtonType.system)
        backButton.setBackgroundImage(#imageLiteral(resourceName: "back86x86"), for: .normal)
        backButton.frame = CGRect(x: 25, y: 28, width: 29, height: 29)
        backButton.addTarget(self, action: #selector(back), for: UIControl.Event.touchUpInside)
        self.view.addSubview(backButton)
    }
    
    @objc func back(sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
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
