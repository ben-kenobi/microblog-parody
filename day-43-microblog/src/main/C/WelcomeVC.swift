



//
//  WelcomeVC.swift
//  day-43-microblog
//
//  Created by apple on 15/12/8.
//  Copyright © 2015年 yf. All rights reserved.
//

import UIKit
import SDWebImage

class WelcomeVC: UIViewController {
    let imgw:CGFloat=90
    lazy var icon:UIImageView={
        let icon=UIImageView(frame: CGRect(x: 0, y: 220, width: self.imgw, height: self.imgw))
        icon.cx=self.view.icx
        
        icon.layer.cornerRadius=self.imgw*0.5
        icon.alpha=0
        icon.layer.masksToBounds=true
        return icon
    }()
    lazy var name:UILabel={
        let lab=UILabel( txt: "welcome back", color:UIColor.orangeColor(), font: iFont(19), line: 1)
        lab.alpha=0
        return lab
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor=UIColor.whiteColor()
        let bg=UIImageView(frame: view.bounds)
        bg.image=iimg("bg")
        view.addSubview(bg)

        view.addSubview(icon)
        icon.sd_setImageWithURL(iUrl(UserInfo.me?.avatar_large), placeholderImage: iimg("avatar_default_big"))
        view.addSubview(name)
        name.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(icon.snp_bottom).offset(10)
            make.centerX.equalTo(0)
        }

    }
    
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        
        UIView.animateWithDuration(0.6, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.7, options: [], animations: { () -> Void in
            self.icon.alpha=1
            self.icon.y=100
            self.icon.layoutIfNeeded()
            }) { (b) -> Void in
                UIView.animateWithDuration(0.4, animations: { () -> Void in
                    self.name.alpha=1
                    dispatch_after(dispatch_time(0, Int64(5e8)), dispatch_get_main_queue(), { () -> Void in
                        iNotiCenter.postNotificationName(updateRootVCNoti, object: nil)
                    })
                })
        }
        
    }
    
}





