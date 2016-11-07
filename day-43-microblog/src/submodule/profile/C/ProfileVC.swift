//
//  ProfileVC.swift
//  day-43-microblog
//
//  Created by apple on 15/12/5.
//  Copyright © 2015年 yf. All rights reserved.
//

import UIKit

class ProfileVC: BaseVC {

    override func loginLoad() {
        super.loginLoad()
        view.backgroundColor=UIColor.randColor()
    }

    override func unloginLoad() {
        super.unloginLoad()
         vistorv?.setInfo(UIImage(named: "visitordiscover_image_profile"), title: "message centeral")
    }
  
}
