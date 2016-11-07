

//
//  MainNavVC.swift
//  day-43-microblog
//
//  Created by apple on 15/12/5.
//  Copyright © 2015年 yf. All rights reserved.
//

import UIKit

class MainNavVC: UINavigationController,UIGestureRecognizerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate=self
    }
    
    
    
    override func pushViewController(viewController: UIViewController, animated: Bool) {
       
        if(childViewControllers.count>1){
            viewController.navigationItem.leftBarButtonItem=UIBarButtonItem(img:UIImage(named: "navigationbar_back_withtext"),hlimg:UIImage(named: "navigationbar_back_withtext_highlighted"), title: "Back"
           , tar: self, action: #selector(MainNavVC.back))
            viewController.hidesBottomBarWhenPushed=true
        }else if(childViewControllers.count==1){
            viewController.navigationItem.leftBarButtonItem=UIBarButtonItem(img:UIImage(named: "navigationbar_back_withtext"),hlimg:UIImage(named: "navigationbar_back_withtext_highlighted"), title: self.childViewControllers.first!.navigationItem.title
                , tar: self, action: #selector(MainNavVC.back))
             viewController.hidesBottomBarWhenPushed=true
        }
        
        super.pushViewController(viewController, animated: animated)
    }
    
    
    func gestureRecognizerShouldBegin(gestureRecognizer: UIGestureRecognizer) -> Bool {
        return childViewControllers.count>1
    }
    
    
    func back(){
        popViewControllerAnimated(true)
    }
}
