


//
//  DiscVC.swift
//  day-43-microblog
//
//  Created by apple on 15/12/5.
//  Copyright © 2015年 yf. All rights reserved.
//

import UIKit

class DiscVC: BaseVC {


  
    
    override func loginLoad() {
        super.loginLoad()
        view.backgroundColor=UIColor.randColor()
        self.navigationItem.titleView=YFCusTF(frame: CGRect(x: 0, y: 0, width: UIScreen.mainScreen().bounds.width-20, height: 35))
        
        self.tabBarItem.badgeValue="11"
                
    }
    
    override func unloginLoad() {
        super.unloginLoad()
         vistorv?.setInfo(UIImage(named: "visitordiscover_image_message"), title: "message centeral")
    }

    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.tabBarItem.badgeValue=nil
        self.tabBarItem.badgeValue="22"
    }
}
