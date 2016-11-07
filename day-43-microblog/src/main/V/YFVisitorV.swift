


//
//  YFVisitorV.swift
//  day-43-microblog
//
//  Created by apple on 15/12/5.
//  Copyright © 2015年 yf. All rights reserved.
//

import UIKit
import SnapKit

class YFVisitorV: UIView {
   override init(frame: CGRect) {
        super.init(frame: frame)
        initUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setInfo(img:UIImage?,title:String){
        self.icon.image=img
        self.message.text=title
        self.circle.hidden=true
    }
    
    
    
    func initUI(){
        
        addSubview(circle)
        addSubview(mask)
        addSubview(icon)
         addSubview(message)
        addSubview(regiBtn)
        addSubview(loginBtn)
        
      let ca =  CABasicAnimation(keyPath: "transform.rotation")
        ca.toValue=2*M_PI
        ca.duration=15
        ca.repeatCount=MAXFLOAT
        ca.removedOnCompletion=false
        
        circle.layer.addAnimation(ca, forKey: nil)
        
        backgroundColor=UIColor(white: 237/255, alpha: 1)
        
        
        autolayout02()
        
    }
    
    
    
    
    
    private lazy var icon=UIImageView(image: iimg("visitordiscover_feed_image_house"))
    private lazy var circle=UIImageView(image: iimg("visitordiscover_feed_image_smallicon"))
    
    private lazy var mask=UIImageView(image: iimg("visitordiscover_feed_mask_smallicon"))
    
    private lazy var message:UILabel={
        let lab=UILabel()
        lab.font=UIFont.systemFontOfSize(17)
        lab.numberOfLines=0
        lab.textColor=UIColor.darkGrayColor()
        lab.text="dkkwjekqjeqwejoqwjeoiqwjieoqwejqiwejoiqwieoqwjeioqwjeioqwjeioqwjeoqwj"
        return lab
    }()
    
    
    lazy var regiBtn:UIButton={
        let b=UIButton()
        b.setTitle("register", forState: UIControlState.Normal)
        b.setTitleColor(UIColor.orangeColor(), forState: UIControlState.Normal)
         b.setBackgroundImage(iimg("common_button_white_disable")?.stretch(), forState: UIControlState.Normal)
        return b
    }()
    lazy var loginBtn:UIButton={
        let b=UIButton()
        b.setTitle("login", forState: UIControlState.Normal)
        b.setTitleColor(UIColor.orangeColor(), forState: UIControlState.Normal)
        b.setBackgroundImage(iimg("common_button_white_disable")?.stretch(), forState: UIControlState.Normal)
        return b
    }()
    
    
    
}


extension YFVisitorV{
    
    func autolayout02(){
        circle.snp_makeConstraints { (make) -> Void in
            make.center.equalTo(0)
        }
        icon.snp_makeConstraints { (make) -> Void in
            make.center.equalTo(0)
        }
        message.snp_makeConstraints { (make) -> Void in
            make.centerX.equalTo(0)
            make.top.equalTo(icon.snp_bottom).offset(10)
            make.width.equalTo(self.snp_width).multipliedBy(0.7)
        }
        regiBtn.snp_makeConstraints { (make) -> Void in
            make.right.equalTo(self.snp_centerX).offset(-20)
            make.top.equalTo(message.snp_bottom).offset(15)
            make.width.equalTo(self.snp_width).multipliedBy(0.3)
            make.height.equalTo(44)
        }
        loginBtn.snp_makeConstraints { (make) -> Void in
            make.leading.equalTo(self.snp_centerX).offset(20)
            make.top.width.height.equalTo(regiBtn)
        }
        mask.snp_makeConstraints { (make) -> Void in
            make.top.left.right.equalTo(0)
            make.bottom.equalTo(loginBtn)
        }
        
        
    }
    
    
    func autolayout01(){
        
        circle.translatesAutoresizingMaskIntoConstraints=false
        addConstraint(NSLayoutConstraint(item: circle, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.CenterX, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: circle, attribute: NSLayoutAttribute.CenterY, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.CenterY, multiplier: 1, constant: 0))
        
        
        //        mask.translatesAutoresizingMaskIntoConstraints=false
        //        addConstraint(NSLayoutConstraint(item: mask, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.CenterX, multiplier: 1, constant: 0))
        //        addConstraint(NSLayoutConstraint(item: mask, attribute: NSLayoutAttribute.CenterY, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.CenterY, multiplier: 1, constant: 0))
        
        
        
        
        icon.translatesAutoresizingMaskIntoConstraints=false
        addConstraint(NSLayoutConstraint(item: icon, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.CenterX, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: icon, attribute: NSLayoutAttribute.CenterY, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.CenterY, multiplier: 1, constant: 0))
        
        
        
        
        message.translatesAutoresizingMaskIntoConstraints=false
        addConstraint(NSLayoutConstraint(item: message, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.CenterX, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: message, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: circle, attribute: NSLayoutAttribute.Bottom, multiplier: 1, constant: 5))
        addConstraint(NSLayoutConstraint(item: message, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Width, multiplier: 0.7, constant: 0))
        
        
        
        regiBtn.translatesAutoresizingMaskIntoConstraints=false
        addConstraint(NSLayoutConstraint(item: regiBtn, attribute: NSLayoutAttribute.Right, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.CenterX, multiplier: 1, constant: -20))
        addConstraint(NSLayoutConstraint(item: regiBtn, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: message, attribute: NSLayoutAttribute.Bottom, multiplier: 1, constant: 15))
        addConstraint(NSLayoutConstraint(item: regiBtn, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Width, multiplier: 0.3, constant: 0))
        addConstraint(NSLayoutConstraint(item: regiBtn, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute:NSLayoutAttribute.Height, multiplier: 1, constant: 44))
        
        
        
        loginBtn.translatesAutoresizingMaskIntoConstraints=false
        addConstraint(NSLayoutConstraint(item: loginBtn, attribute: NSLayoutAttribute.Left, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.CenterX, multiplier: 1, constant: 20))
        addConstraint(NSLayoutConstraint(item: loginBtn, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: regiBtn, attribute: NSLayoutAttribute.Top, multiplier: 1, constant:0 ))
        addConstraint(NSLayoutConstraint(item: loginBtn, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: regiBtn, attribute: NSLayoutAttribute.Width, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: loginBtn, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: regiBtn, attribute:NSLayoutAttribute.Height, multiplier: 1, constant: 0))
        
        mask.translatesAutoresizingMaskIntoConstraints=false
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[mask]-0-|", options: [], metrics: nil, views: ["mask":mask]))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[mask]-(offset)-[regi]", options: [], metrics: ["offset":-44], views: ["mask":mask,"regi":regiBtn]))
        
    }
    
    
    
    
    
}
