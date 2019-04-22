//
//  XNCPhotoWallViewController.swift
//  softwarePra_contacts
//
//  Created by 03 on 2019/4/17.
//  Copyright © 2019 03. All rights reserved.
//

import UIKit

class XNCPhotoWallViewController: UIViewController{
    var actionButton: ActionButton!
    var waterFallPath = ""
    var width: CGFloat!
    var menuFirstViewController : XNCPhotoWallViewController!
    
    var imageModelList: [WaterFallLayoutModel] = [WaterFallLayoutModel](){
        didSet{
            if self.collectionView != nil{
                self.collectionView.reloadData()
            }
        }
    }
    var images = [UIImage]()
    var collectionView:UICollectionView!
    var maskView: UIView!
    var cellRect: CGRect!
    var changeRect: CGRect!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = GRAY_BACKGROUND_COLOR
        //WaterFall 的第二次尝试,根据长宽自适应高度，基本实现
        waterfallCollectionView()
    }
    
    private func waterfallCollectionView() {
        print("waterfallConllectionView")
        width = (view.bounds.size.width - 20)/2
        let layout = WCLWaterFallLayout.init(lineSpacing: 3, columnSpacing: 3, sectionInsets: UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0))
        layout.delegate = self
        waterFallPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).last!
        print("waterFallPath=\(waterFallPath)")
        //先看缓存
        let  waterFallImagesPath = waterFallPath + "/waterFallImages.array"
        let waterFallImageModelList =  NSKeyedUnarchiver.unarchiveObject(withFile: waterFallImagesPath)
        if waterFallImageModelList != nil {
            self.imageModelList = waterFallImageModelList as! [WaterFallLayoutModel]
            for i in 0..<self.imageModelList.count{
                let model = self.imageModelList[i]
                let imageName  = self.waterFallPath + "/" + model.imageName
                let image = UIImage.init(contentsOfFile: imageName)
                if image == nil{
                    self.images.append(UIImage())
                }else{
                    //image = UIImage.fixOrientation(image!)
                    self.images.append(image!)
                }
            }
        }else{
            //缓存没有
            imageModelList = [WaterFallLayoutModel]()
            images = [UIImage]()
            for i in 1..<7 {
                let  image = UIImage(named: String.init(format: "%d.jpg", i))
                //image = UIImage.fixOrientation(image!)
                let uuid = NSUUID.init().uuidString + ".png"//
                let imageName  =  uuid
                let model = WaterFallLayoutModel()
                model.imageName = imageName
                model.imageSizeW = String.init(format: "%.2f", image!.size.width)
                model.imageSizeH = String.init(format: "%.2f", image!.size.height)
                images.append(image!)
                imageModelList.append(model)
                
            }
            for i in 0..<self.imageModelList.count {
                let model = self.imageModelList[i]
                let imageName  = self.waterFallPath + "/" + model.imageName
                let image = images[i]
                NSData.init(data: image.pngData()!).write(toFile:imageName , atomically: true)
                
            }
            NSKeyedArchiver.archiveRootObject(self.imageModelList, toFile: waterFallImagesPath)
            
        }
        
        
        let frame = CGRect.init(x: 3, y: 0, width: ScreenW - 6, height: ScreenH - 64 - 20)
        collectionView = UICollectionView(frame: frame, collectionViewLayout: layout)
        collectionView.register(WaterFallLayoutCell.classForCoder(), forCellWithReuseIdentifier: "newCell")
        collectionView.backgroundColor = GRAY_BACKGROUND_COLOR
        collectionView.alwaysBounceVertical = true
        
        collectionView.delegate = self
        collectionView.dataSource = self
        view.addSubview(collectionView)
        collectionView.reloadData()
        
        print("ScreenH=\(ScreenH)")
        print("frame=\(self.view.frame)")
    }
    
    @objc func showPic(btn:UIButton){
        UIView.animate(withDuration: 1, animations: {
            btn.frame = self.cellRect
        }) { (finish) in
            btn.removeFromSuperview()
            self.maskView.removeFromSuperview()
            self.maskView = nil
            self.cellRect = nil
        }
    }
    
    
}
extension XNCPhotoWallViewController :UICollectionViewDataSource,WCLWaterFallLayoutDelegate,UICollectionViewDelegate {
    //MARK: --UICollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageModelList.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "newCell", for: indexPath as IndexPath) as! WaterFallLayoutCell
        cell.imageV.frame = CGRect.init(x: 0, y: 0, width: cell.bounds.size.width, height: cell.bounds.size.height)
        let model = imageModelList[indexPath.row]
        let imageName = waterFallPath + "/" + model.imageName
        if self.images[indexPath.row].size.width <= 0 {
            DispatchQueue.global().asyncAfter(deadline: DispatchTime.now()) {
                let image = UIImage.init(contentsOfFile: imageName)
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()) {
                    cell.imageV.image = image
                    self.images[indexPath.row]  = image ?? UIImage()
                }
            }
        }else{
            let image = self.images[indexPath.row]
            let aa = image.imageOrientation
            cell.imageV.image = image
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        maskView = UIView.init(frame: view.bounds)
        maskView.backgroundColor = UIColor.black
        maskView.alpha = 0.5
        view.addSubview(maskView)
        
        //cell在veiw的位置
        cellRect = cell!.convert(cell!.bounds, to: view)
        let btn = WaterButton.init(frame: cellRect)
        let model = imageModelList[indexPath.row]
        let image = UIImage.init(contentsOfFile: waterFallPath + "/" + model.imageName)
        if image == nil {
            return
        }
        let img = image!
        btn.wImage = img
        btn.addTarget(self, action: #selector(showPic(btn:)), for: .touchUpInside)
        view.addSubview(btn)
        //图片长宽的比例与屏幕长宽的比例的对比
        var changeH:CGFloat
        var changeW:CGFloat
        if img.size.width/img.size.height >= view.frame.size.width/view.frame.size.height{
            //对比图片实际宽与屏幕宽
            if img.size.width>view.frame.size.width {
                changeH = img.size.height*view.frame.size.width/img.size.width
                changeRect = CGRect(x: 0, y: (view.frame.size.height-changeH)/2, width:view.frame.size.width, height: changeH)
            }else{
                changeRect = CGRect(x: (view.frame.size.width-img.size.width)/2, y: (view.frame.size.height-img.size.height)/2, width: img.size.width,height: img.size.height)
            }
        }else{
            if img.size.height>view.frame.size.height {
                changeW = img.size.width*view.frame.size.height/img.size.height
                changeRect = CGRect(x: (view.frame.size.width-changeW)/2, y: 0, width: changeW, height: view.frame.size.height)
            }else{
                changeRect = CGRect(x: (view.frame.size.width-img.size.width)/2, y: (view.frame.size.height-img.size.height)/2, width: img.size.width,height: img.size.height)
            }
        }
        
        UIView.animate(withDuration: 1, animations: {
            btn.frame = self.changeRect
        })
        
    }
    func columnOfWaterFall(_ collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func waterFall(_ collectionView: UICollectionView, layout waterFallLayout: WCLWaterFallLayout, heightForItemAt indexPath: IndexPath) -> CGFloat {
        let model = self.imageModelList[indexPath.row]
        let SizeW = Double(model.imageSizeW)
        let W = CGFloat(SizeW ?? 0)
        let SizeH = Double(model.imageSizeH)
        let H = CGFloat(SizeH ?? 0)
        
        let cellW = ScreenW * 0.5 - 4.5
        let cellH = H / W * cellW
        return cellH
        
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
