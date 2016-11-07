

//
//  MessageVC.swift
//  day-43-microblog
//
//  Created by apple on 15/12/5.
//  Copyright © 2015年 yf. All rights reserved.
//

import UIKit

class MessageVC: BaseVC {

 
    override func loginLoad() {
        super.loginLoad()
        view.backgroundColor=UIColor.randColor()
        navigationItem.rightBarButtonItem=UIBarButtonItem(title: "发现群",  tar: self, action: #selector(MessageVC.onRightClick))
    }
    
    override func unloginLoad() {
        super.unloginLoad()
        vistorv?.setInfo(UIImage(named: "visitordiscover_image_message"), title: "message centeral")

    }
    
    func onRightClick(){
        navigationController?.pushViewController(ShowVC01(), animated: true)
    }
   
}
