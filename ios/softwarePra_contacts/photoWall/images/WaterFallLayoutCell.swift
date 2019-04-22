//
//  WaterFallLayoutCell.swift
//  lanShan_Git_1.0
//
//  Created by WuJiLei on 2019/2/25.
//  Copyright © 2019年 OS X. All rights reserved.
//

import UIKit

class WaterFallLayoutCell: UICollectionViewCell {
    let imageV  = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSub()
    }
    //    override func layoutSubviews() {
    //        self.addSub()
    //        super.layoutSubviews()
    //
    //    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addSub() -> (){
        self.contentView.addSubview(imageV)
        imageV.contentMode = UIView.ContentMode.scaleAspectFit
        //UIViewContentModeScaleAspectFill
        
    }
}
