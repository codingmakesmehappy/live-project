//
//  XNCContactViewController.swift
//  softwarePra_contacts
//
//  Created by 03 on 2019/4/17.
//  Copyright © 2019 03. All rights reserved.
//

import UIKit
import PagingMenuController
//分页菜单配置
private struct PagingMenuOptions:PagingMenuControllerCustomizable{
    //默认显示第1页
    var defaultPage: Int = 0
    //允许左右滑动页面切换
    var isScrollEnabled: Bool = true
    //菜单显示模式（分段模式）
    var displayMode: MenuDisplayMode {
        return .segmentedControl
    }
    
    //子视图控制器
    private let viewController1 = XNCPhotoWallViewController()
    private let viewController2 = XNCPeoplesViewController()
    //组件类型
    fileprivate var componentType: ComponentType {
        return .all(menuOptions: MenuOptions(), pagingControllers: pagingControllers)
    }
    //所有子视图控制器
    fileprivate var pagingControllers: [UIViewController] {
        return [viewController1, viewController2]
    }
    
    //菜单配置项
    fileprivate struct MenuOptions: MenuViewCustomizable {
        //菜单显示模式
        var displayMode: MenuDisplayMode {
            return .segmentedControl
        }
        //菜单项
        var itemsOptions: [MenuItemViewCustomizable] {
            return [MenuItem1(), MenuItem2()]
        }
    }
    
    //第1个菜单项
    fileprivate struct MenuItem1: MenuItemViewCustomizable {
        var horizontalMargin: CGFloat = 5
        //自定义菜单项名称
        var displayMode: MenuItemDisplayMode {
            return .text(title: MenuItemText(text: "精彩记录", color: .lightGray, selectedColor: UIColor(red: 85/225, green: 214/225, blue: 162/225, alpha: 1), font: UIFont.systemFont(ofSize: 13), selectedFont: UIFont.systemFont(ofSize: 13)))
        }
    }
    
    //第2个菜单项
    fileprivate struct MenuItem2: MenuItemViewCustomizable {
        //自定义菜单项名称
        var displayMode: MenuItemDisplayMode {
            return .text(title: MenuItemText(text: "我的抽奖", color: .lightGray, selectedColor: UIColor(red: 85/225, green: 214/225, blue: 162/225, alpha: 1), font: UIFont.systemFont(ofSize: 13), selectedFont: UIFont.systemFont(ofSize: 13)))
        }
    }
}
class XNCContactViewController: UIViewController,UITextFieldDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    //右下角的悬浮按钮
    var actionButton: ActionButton!
    
    var menuFirstViewController : XNCPhotoWallViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //分页菜单配置
        let options = PagingMenuOptions()
        //分页菜单控制器初始化
        let pagingMenuController = PagingMenuController(options: options)
        //分页菜单控制器尺寸设置
        pagingMenuController.view.frame.origin.y += 64
        pagingMenuController.view.frame.size.height -= 64
        
        //建立父子关系
        addChild(pagingMenuController)
        //分页菜单控制器视图添加到当前视图中
        view.addSubview(pagingMenuController.view)
        pagingMenuController.onMove = {
            status in
            switch status {
            case let .willMoveController(to:menuController, from:previousMenuController):
                if previousMenuController == self.menuFirstViewController {
                    self.actionButton.floatButton.isHidden = true
                }
                if menuController == self.menuFirstViewController{
                    self.actionButton.floatButton.isHidden = false
                }
                print("111111111")
            case .willMoveItem(to: _, from: _):
                print("2222222222")
            case .didMoveItem(to: _, from: _):
                print("33333333333333")
            case .didMoveController(to: _, from: _):
                print("4444444444444")
            case .didScrollStart:
                print("Scroll start")
            case .didScrollEnd:
                print("Scroll end")
            }
        }
        //获取到第二个子控制器, 方便选择照片后传值
        let childs =  pagingMenuController.pagingViewController?.children
        for child in childs! {
            if child.isKind(of: XNCPhotoWallViewController.self){
                menuFirstViewController = child as? XNCPhotoWallViewController
                break
            }
        }
        if menuFirstViewController  == nil{
            menuFirstViewController = XNCPhotoWallViewController()
        }
        //设置悬浮按钮
        addActionButton()
    }
    //悬浮按钮函数
    func addActionButton() -> Void {
        let twitterImage = UIImage(named: "point.png")!
        let plusImage = UIImage(named: "point.png")!
        
        let google = ActionButtonItem(title: "拍照", image: plusImage)
        google.action = {
            item in print("Google Plus...")
            self.initCameraPicker()
        }
        
        let twitter = ActionButtonItem(title: "从相册获取", image: twitterImage)
        twitter.action = {
            item in print("Twitter...")
            self.initPhotoPicker()
        }
        actionButton = ActionButton(attachedToView: self.view, items: [twitter, google])
        actionButton.action = { button in button.toggleMenu() }
        // 在这里设置按钮的相关属性，其实就是把刚刚那两个文件中的原始属性给覆盖了一遍，这里仅覆盖了2个旧属性
        actionButton.setTitle("+", forState: .normal)
        
        actionButton.backgroundColor = UIColor(red: 85/225, green: 214/225, blue: 162/225, alpha: 1)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    //从相册中选择
    func initPhotoPicker(){
        let photoPicker =  UIImagePickerController()
        photoPicker.delegate = self
        photoPicker.allowsEditing = true
        photoPicker.sourceType = .photoLibrary
        //在需要的地方present出来
        self.present(photoPicker, animated: true, completion: nil)
    }
    //拍照获取
    func initCameraPicker(){
        
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            let  cameraPicker = UIImagePickerController()
            cameraPicker.delegate = self
            //as? UIImagePickerControllerDelegate & UINavigationControllerDelegate
            cameraPicker.allowsEditing = true
            cameraPicker.sourceType = .camera
            //在需要的地方present出来
            self.present(cameraPicker, animated: true, completion: nil)
        } else {
            print("不支持拍照")
        }
        
    }
    //选中图片后会调用该方法
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        var image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        
        if image == nil {
            self.dismiss(animated: true, completion: nil)
            return
        }
        //图片方向纠正
        image = UIImage.fixOrientation(image!)
        actionButton.hiddleView = true
        self.dismiss(animated: true, completion: nil)
        let waterFallPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).last!
        
        let  waterFallImagesPath = waterFallPath + "/waterFallImages.array"//老
        let imageName  =   NSUUID.init().uuidString + ".png"
        NSData.init(data: image!.pngData()!).write(toFile:waterFallPath + "/" + imageName , atomically: true)
        
        //要缓存
        let model = WaterFallLayoutModel()
        model.imageSizeW = String.init(format: "%.2f", image!.size.width)
        model.imageSizeH = String.init(format: "%.2f", image!.size.height)
        model.imageName = imageName
        self.menuFirstViewController.images = [image!] + self.menuFirstViewController.images
        let imageModelList =  [model] + self.menuFirstViewController.imageModelList
        self.menuFirstViewController.imageModelList = imageModelList
        NSKeyedArchiver.archiveRootObject(imageModelList, toFile: waterFallImagesPath)
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
