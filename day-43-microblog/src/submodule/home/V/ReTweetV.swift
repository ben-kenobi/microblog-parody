






//
//  ReTweetV.swift
//  day-43-microblog
//
//  Created by apple on 15/12/10.
//  Copyright © 2015年 yf. All rights reserved.
//

import UIKit

class ReTweetV: UIView {
    

    
    
    var mod:HomeMod?{
        didSet{
            content.attributedText=mod?.retAttRes.atr
            content.reses=mod?.retAttRes.reses
            picsCV.pics=mod?.pic_urls
        }
    }
 
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(content)
        content.snp_makeConstraints { (make) -> Void in
            make.left.top.equalTo(10)
            make.right.equalTo(-10)

        }
        
        addSubview(picsCV)
        picsCV.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(content.snp_bottom).offset(0)
            make.left.equalTo(10)
            make.bottom.equalTo(-10)
            make.height.width.equalTo(0)
        }
        
        backgroundColor=UIColor(white: 0.95, alpha: 1)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    private lazy var content:HomeLab = HomeLab(color: UIColor.darkGrayColor(), font: iFont(15), line:0)
    private lazy var picsCV:BlogPicV = BlogPicV()
    
}
