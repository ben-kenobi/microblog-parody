
//
//  MainVM.swift
//  day-43-microblog
//
//  Created by apple on 15/12/17.
//  Copyright © 2015年 yf. All rights reserved.
//

import UIKit

class MainVM: NSObject {
    
    
    class func postBlog(str:String,imgs:[UIImage]?,cb:((suc:Bool)->())?){
        print(str)
        if let imgs = imgs where imgs.count > 0 {
            uploadBlog(str, imgs: imgs, cb: cb)
            return
        }
        updateBlog(str, cb: cb)
    }
    
    class func updateBlog(str:String,cb:((suc:Bool)->())?){
        let url="https://api.weibo.com/2/statuses/update.json"
        let para:[String:AnyObject]=["access_token":UserInfo.me?.access_token ?? "","status":str]
        INet.request(false, url: url, para:para , cb: { (data, resp) -> () in
            cb?(suc:true)
            }) { (err, resp) -> () in
                iCommonLog(err)
                cb?(suc:false)
                guard let data=err.userInfo["com.alamofire.serialization.response.error.data"] as? NSData else {
                    return
                }
                print(String(data: data, encoding: 4)!)
                
        }
    }
    
    class func uploadBlog(str:String,imgs:[UIImage],cb:((suc:Bool)->())?){
        let url="https://upload.api.weibo.com/2/statuses/upload.json"
        let para:[String:AnyObject]=["access_token":UserInfo.me?.access_token ?? "","status":str]
        var datas:[String:NSData]=[String:NSData]()
        for img in imgs{
            datas["pic"]=UIImagePNGRepresentation(img)
        }
        
        INet.upload(url, para: para, datas:datas,cb:{ (data, resp) -> () in
                cb?(suc:true)
            }){ (err, resp) -> () in
                iCommonLog(err)
                cb?(suc:false)
        }
    }
    
}
