//
//  WaterButton.swift
//  lanShan_Git_1.0
//
//  Created by OS X on 2019/2/17.
//  Copyright © 2019 OS X. All rights reserved.
//

import UIKit
//用于点击cell得到大图
class WaterButton: UIButton {

    var wImage:UIImage!{
        didSet{
            wImageView.image = wImage
        }
    }
    private var wImageView:UIImageView!
    override init(frame: CGRect) {
        super.init(frame: frame)
        wImageView = UIImageView(frame:bounds)
        addSubview(wImageView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        wImageView.frame = bounds
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    /*
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
