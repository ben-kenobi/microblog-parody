

//
//  NewFeatureVC.swift
//  day-43-microblog
//
//  Created by apple on 15/12/8.
//  Copyright © 2015年 yf. All rights reserved.
//

import UIKit

class NewFeatureVC: UIViewController,UIScrollViewDelegate {
    lazy var sv:UIScrollView={
       let sv = UIScrollView(frame: self.view.bounds)
        sv.pagingEnabled=true
        sv.bounces=false
        sv.delegate=self
        sv.showsHorizontalScrollIndicator=false
        return sv
    }()
    
    lazy var pc:UIPageControl={
        let pc=UIPageControl()
        pc.pageIndicatorTintColor=UIColor.orangeColor()
        pc.currentPageIndicatorTintColor=UIColor.redColor()
        
        return pc
    }()
    
    
    lazy var share:UIButton={
        let btn=UIButton(img: iimg("new_feature_share_false"), hlimg: iimg("new_feature_share_true"), title: " share2blog", font: iFont(19), titleColor: iColor(100, g: 100, b: 100),  tar: self, action: #selector(NewFeatureVC.onClick(_:)), tag: 0)
        btn.setImage(iimg("new_feature_share_true"), forState: UIControlState.Selected)
        btn.center=CGPointMake(self.sv.icx, self.sv.icy+150)
        btn.sizeToFit()
            btn.imageEdgeInsets=UIEdgeInsetsMake(3, 0, 0, 0)
        return btn
        
    }()
    
    lazy var btn:UIButton={
        let btn=UIButton( title: "进入应用", font: ibFont(19), titleColor: iColor(180, g: 180, b: 180), bgimg: iimg("new_feature_finish_button"), hlbgimg: iimg("new_feature_finish_button_highlighted"),tar: self, action: #selector(NewFeatureVC.onClick(_:)), tag: 0)
        btn.center=CGPointMake(self.sv.icx, self.sv.icy+200)
        btn.sizeToFit()
        return btn
    }()
    
    
    
    func onClick(btn:UIButton){
        if btn==self.share{
            btn.selected = !btn.selected
        }else if btn==self.btn{
            dispatch_after(dispatch_time(0, Int64(5e8)), dispatch_get_main_queue(), { () -> Void in
                iNotiCenter.postNotificationName(updateRootVCNoti, object: nil)
            })
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(sv)
        
        view.addSubview(pc)

        pc.snp_makeConstraints { (make) -> Void in
            make.bottom.equalTo(-50)
            make.centerX.equalTo(0)
        }
    
        let count=4
       
        pc.numberOfPages=count
        for var i in 0..<count{
            let iv=UIImageView(frame: sv.bounds)
            iv.x=CGFloat(i) * sv.w
            iv.image=iimg("new_feature_\(i+1)")
            sv.addSubview(iv)
            if(i==count-1){
                iv.addSubview(share)
                iv.addSubview(btn)
                iv.userInteractionEnabled=true
            }
        }
        sv.contentSize=CGSize(width: sv.w * CGFloat(count), height: 0)
        
    }
    
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView){
        pc.currentPage=Int(scrollView.contentOffset.x/scrollView.w)
    }
    
}
