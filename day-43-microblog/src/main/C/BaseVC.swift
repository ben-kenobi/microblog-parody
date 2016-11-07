

//
//  BaseVC.swift
//  day-43-microblog
//
//  Created by apple on 15/12/5.
//  Copyright © 2015年 yf. All rights reserved.
//

import UIKit

class BaseVC: UIViewController {
    var vistorv:YFVisitorV?
    
    override func loadView() {
        UserInfo.isLogin() ? super.loadView():self.setupView()
    }
    
    private func setupView(){
        vistorv=YFVisitorV()
        view=vistorv

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UserInfo.isLogin() ?  loginLoad() : unloginLoad()
    }
    
    func loginLoad(){
    
    
    }
    
    func unloginLoad(){
        self.navigationItem.leftBarButtonItem=UIBarButtonItem(title:"登录", tar: self, action: #selector(BaseVC.loginclick))
        
        self.navigationItem.rightBarButtonItem=UIBarButtonItem(title:"注册", tar: self, action: #selector(BaseVC.regiclick))
        
        vistorv?.loginBtn.addTarget(self, action: #selector(BaseVC.loginclick), forControlEvents: UIControlEvents.TouchUpInside)
        vistorv?.regiBtn.addTarget(self, action: #selector(BaseVC.regiclick), forControlEvents: UIControlEvents.TouchUpInside)
    
    }
    
    
    func loginclick(){
        navigationController?.pushViewController(LoginWebVC(), animated: true)
    }
    
    func regiclick(){

    }
    
}
