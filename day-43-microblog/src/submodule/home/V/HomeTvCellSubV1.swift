




//
//  HomeTvCellSubV1.swift
//  day-43-microblog
//
//  Created by apple on 15/12/9.
//  Copyright © 2015年 yf. All rights reserved.
//

import UIKit

class HomeTvCellSubV1: UIView {
    var retweet: UIButton?
    var comment: UIButton?
    var unlike: UIButton?
    
    
    var mod:HomeMod?{
        didSet{
            retweet?.setTitle(mod?.retwCount ?? "转发")
            comment?.setTitle(mod?.commentCount ?? "评论")
            unlike?.setTitle(mod?.attitudeCount ?? "赞")
        }
    }
    
    
    
    
    func initUI(){
        let newb={
            (img:String)->UIButton in
            let b=UIButton( img: iimg(img), font: iFont(14), titleColor: UIColor.grayColor(), titleHlColor: UIColor.darkGrayColor(), bgimg: iimg("timeline_card_bottom_background"), hlbgimg: iimg("timeline_card_bottom_background_highlighted"), action: "", tag: 0)
            self.addSubview(b)
            return b
        }
        
        retweet=newb("timeline_icon_retweet")
        comment=newb("timeline_icon_comment")
        unlike=newb("timeline_icon_unlike")
        
        retweet?.snp_makeConstraints(closure: { (make) -> Void in
            make.left.top.bottom.equalTo(0)
        })
        comment?.snp_makeConstraints(closure: { (make) -> Void in
            make.top.bottom.equalTo(0)
            make.left.equalTo(retweet!.snp_right)
            make.width.equalTo(retweet!)
        })
        unlike?.snp_makeConstraints(closure: { (make) -> Void in
            make.top.bottom.right.equalTo(0)
            make.left.equalTo(comment!.snp_right)
            make.width.equalTo(retweet!)
        })
        
        let newv={
            ()->UIView in
            let v=UIView()
            self.addSubview(v)
            v.backgroundColor=UIColor.lightGrayColor()
            return v
        }
        
        let line1=newv()
        let line2=newv()
       
        
        line1.snp_makeConstraints { (make) -> Void in
            make.centerY.equalTo(0)
            make.centerX.equalTo(retweet!.snp_right)
            make.height.equalTo(self).multipliedBy(0.4)
            make.width.equalTo(1)
        }
        
        line2.snp_makeConstraints { (make) -> Void in
            make.centerY.equalTo(0)
            make.centerX.equalTo(comment!.snp_right)
            make.height.equalTo(self).multipliedBy(0.4)
            make.width.equalTo(1)
        }
    }
    
    
    init(){
        super.init(frame: CGRectMake(0, 0, 0, 0))
        initUI()


    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
