//
//  XNCPeoplesViewController.swift
//  softwarePra_contacts
//
//  Created by 03 on 2019/4/17.
//  Copyright © 2019 03. All rights reserved.
//

import UIKit

class XNCPeoplesViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate{
    var tableView : UITableView!
    let searchBar = UISearchBar.init()
    var calendarModelList = [AddCalendarModel]()
    var result = [String]()
    
    //cell个数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return calendarModelList.count
    }
    //对每个cell进行的设置
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier="MenuThirdViewControllerID";
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! CalendarCell
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        let model = calendarModelList[indexPath.row]
        
        let CreatDate = model.CreatDate
        let array = CreatDate.components(separatedBy: "-")
        cell.dayLab.text =  array[2]
        cell.monthLab.text = array[1] + "月"
        
        cell.titleLab.text = model.title
        cell.detailsLab.text = model.details
        cell.addressLab.text = model.address
        cell.emailLab.text = model.email
        cell.phoneLab.text = model.phoneNum
        cell.wechatLab.text = model.wechat
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //跳转到详情页面
        let DetailsVC = ContactDetailsViewController()
        DetailsVC.calendarModel = self.calendarModelList[indexPath.row]
        
        weak var weakSelf : XNCPeoplesViewController! = self
        DetailsVC.deteleblock = {
            () -> Void in
            weakSelf.calendarModelList.remove(at: indexPath.row)
            weakSelf.tableView.reloadData()
            let calendarPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).last! +  "/calendar.array"
            print("calendarPath=\(calendarPath)")
            //先看缓存
            NSKeyedArchiver.archiveRootObject(weakSelf.calendarModelList, toFile: calendarPath)
        }
        self.present(DetailsVC, animated: false, completion: nil)
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        return 110 + 15
    }
    //设置cell圆角
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath){
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let calendarPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).last! +  "/calendar.array"
        print("calendarPath=\(calendarPath)")
        //先看缓存
        let calendarModelListTemp = NSKeyedUnarchiver.unarchiveObject(withFile: calendarPath) as? [AddCalendarModel]
        if calendarModelListTemp != nil {
            self.calendarModelList = calendarModelListTemp!
        }
        //右下角的悬浮按钮
        let addButton = UIButton(type: UIButton.ButtonType.system)
        //设置searchbar
        searchBar.frame = CGRect.init(x: 10, y: 5, width: ScreenW-20, height: 35)
        searchBar.delegate = self
        searchBar.backgroundColor = UIColor.white
        searchBar.barStyle = .default
        searchBar.barTintColor = UIColor.white
        searchBar.layer.borderWidth = 0.8
        searchBar.layer.borderColor = UIColor.white.cgColor
        searchBar.layer.shadowRadius = 5
        searchBar.layer.shadowOpacity = 0.45
        searchBar.layer.shadowOffset = CGSize(width: 0, height: 1)
        //搜索内容为空时
        //self.view.addSubview(searchBar)
        
        //设置tableView
        let tableView = UITableView(frame: CGRect(x: 0, y: 3, width: ScreenW, height: ScreenH - statusBarH - 3), style: .plain)
        self.tableView = tableView
        tableView.backgroundColor = GRAY_BACKGROUND_COLOR
        tableView.register( CalendarCell.classForCoder(), forCellReuseIdentifier: "MenuThirdViewControllerID")
        tableView.dataSource = self
        tableView.delegate = self
        //设置悬浮按钮
        addButton.setBackgroundImage(UIImage(named: "add"), for: .normal)
        addButton.frame = CGRect(x: ScreenW - 60 , y: ScreenH - 250, width: 50, height: 50)
        addButton.addTarget(self, action: #selector(addDiary), for: .touchUpInside)
        addButton.layer.shadowColor = UIColor.init(red: 129/225, green: 129/225, blue: 129/225, alpha: 1).cgColor
        addButton.layer.shadowOffset = CGSize(width: 0, height: 1)
        addButton.layer.shadowOpacity = 0.45
        addButton.layer.shadowRadius = 10
        
        //卡片式设置
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        tableView.separatorInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        //必须先tableView再aaddButton不然会被覆盖
        self.view.addSubview(tableView)
        self.view.addSubview(addButton)
        
    }
    //添加信息按钮
    @objc func addDiary(){
        //跳转到详情页面
        let addVC = AddContactsViewController()
        addVC.calendarModelList = calendarModelList
        weak var weakSelf : XNCPeoplesViewController! = self
        addVC.refreshblock = {
            (calendarModelList :[AddCalendarModel]) -> Void in
            weakSelf.calendarModelList =  calendarModelList
            weakSelf.tableView.reloadData()
        }
        self.present(addVC, animated: false, completion: nil)
    }
}
