


//
//  LoginWebVC.swift
//  day-43-microblog
//
//  Created by apple on 15/12/6.
//  Copyright © 2015年 yf. All rights reserved.
//

import UIKit



class LoginWebVC: YFWebVC {
    
 
    
    var code:String?
    var accessToken:String?
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor=UIColor.whiteColor()
        wv.loadRequest(iReq(String(format: UserInfo.Auth_url, UserInfo.App_Key,UserInfo.CB_url)))
        view.addSubview(wv)
        navigationItem.rightBarButtonItem=UIBarButtonItem(title: "auto",  tar: self, action: #selector(LoginWebVC.autoInput))
        
    }
    
    
    func autoInput(){
    wv.stringByEvaluatingJavaScriptFromString("document.getElementById('userId').value='yohtr35601@163.com';document.getElementById('passwd').value='qw1987';")
    }
    
    func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool{
        let str=request.URL?.absoluteString
        print(str)
        if str != nil&&str!.hasPrefix(UserInfo.CB_url) {
            if !(str!.componentsSeparatedByString("?").last!.hasPrefix("code")){
                self.navigationController?.popViewControllerAnimated(true)
                return false
            }
            code=str!.componentsSeparatedByString("=").last
            guard let cod=code else{
                return false
            }
            
            iPop.showProg()
            UserInfo.requestToken(cod, cb: { (suc) -> () in
                 iPop.dismProg()
                if(suc){
                    iNotiCenter.postNotificationName(updateRootVCNoti, object: nil)
                }else{
                self.wv.stringByEvaluatingJavaScriptFromString("document.getElementById('userId').value='fail'")
                }
            })
            return false
        }
        
        return true
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        iPop.dismProg()
    }
    
   
    
 
}
