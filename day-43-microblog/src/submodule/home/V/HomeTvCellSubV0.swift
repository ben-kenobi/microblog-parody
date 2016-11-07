



//
//  HomeTvCellSubV0.swift
//  day-43-microblog
//
//  Created by apple on 15/12/9.
//  Copyright © 2015年 yf. All rights reserved.
//

import UIKit
import SnapKit

class HomeTvCellSubV0: UIView {

    
    let pad:CGFloat=10
    var mod:HomeMod?{
        didSet{
           iconView.sd_setImageWithURL(iUrl(mod?.user?.profile_image_url), placeholderImage: iimg("avatar_default_big"))
            nameLabel.text=mod?.user?.name
            timeLabel.text=mod?.postTime
            sourceLabel.text=mod?.sourceTxt
            vipImageView.image=mod?.vipImg
            verifiedImageView.image=mod?.veriImg
            contentLabel.attributedText=mod?.attRes.atr
            contentLabel.reses=mod?.attRes.reses
            picsCV.pics=mod?.pic_urls
        }
    }
    
    init(){
        super.init(frame:CGRectMake(0, 0, 0, 0))
        addSubview(iconView)
        addSubview(nameLabel)
        addSubview(vipImageView)
        addSubview(timeLabel)
        addSubview(sourceLabel)
        addSubview(verifiedImageView)
        addSubview(contentLabel)
        addSubview(picsCV)
        
        iconView.snp_makeConstraints { (make) -> Void in
            make.top.left.equalTo(pad)
            make.height.width.equalTo(35)
        }
        
        nameLabel.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(pad)
            make.left.equalTo(iconView.snp_right).offset(pad)
        }
        vipImageView.snp_makeConstraints { (make) -> Void in
            make.centerY.equalTo(nameLabel)
            make.left.equalTo(nameLabel.snp_right).offset(pad)
        }
        
        timeLabel.snp_makeConstraints { (make) -> Void in
            make.bottom.equalTo(iconView)
            make.left.equalTo(nameLabel)
        }
        sourceLabel.snp_makeConstraints { (make) -> Void in
            make.centerY.equalTo(timeLabel)
            make.left.equalTo(timeLabel.snp_right).offset(pad)
        }
        
        verifiedImageView.snp_makeConstraints { (make) -> Void in
            make.centerX.equalTo(iconView.snp_right)
            make.centerY.equalTo(iconView.snp_bottom)
        }
        
        contentLabel.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(pad)
            make.right.equalTo(-pad)
            make.top.equalTo(iconView.snp_bottom).offset(pad)
//            make.bottom.equalTo(-pad)
        }
        
        
        
        picsCV.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(contentLabel.snp_bottom).offset(0)
            make.left.equalTo(pad)
            make.bottom.equalTo(0)
            make.height.width.equalTo(0)
        }

        self.backgroundColor=UIColor.whiteColor()
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    
    
    
    
    
    // MARK: - 懒加载控件
    // 头像控件
    private lazy var iconView: UIImageView = UIImageView(image: UIImage(named: "avatar_default_big"))
    
    // 昵称label
    private lazy var nameLabel: UILabel = UILabel( color: UIColor.darkGrayColor(), font: iFont(14), line: 1)
    // 时间
    private lazy var timeLabel: UILabel = UILabel(color: UIColor.orangeColor(), font: iFont(10),line:1)
    // 来源
    private lazy var sourceLabel: UILabel = UILabel(color: UIColor.lightGrayColor(), font:iFont(10),line:1)
    // 会员图标
    private lazy var vipImageView: UIImageView = UIImageView(image: UIImage(named: "common_icon_membership"))
    // 认证
    private lazy var verifiedImageView: UIImageView = UIImageView(image: UIImage(named: "avatar_vip"))
    
    // 微博内容
    private lazy var contentLabel: HomeLab = HomeLab(color: UIColor.darkGrayColor(), font: iFont(15)  , line:0)
    
    private lazy var picsCV:BlogPicV=BlogPicV()
}
