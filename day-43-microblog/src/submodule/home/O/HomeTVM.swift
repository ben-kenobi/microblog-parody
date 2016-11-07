


//
//  HomeTVM.swift
//  day-43-microblog
//
//  Created by apple on 15/12/9.
//  Copyright © 2015年 yf. All rights reserved.
//

import UIKit
import SDWebImage

class HomeTVM: NSObject {

     lazy var mod:[HomeMod]={
        return [HomeMod]()
    }()
    

    
    func loadHomeDatas(token:String?,new:Bool=false,cb:((b:Bool,count:Int)->())?){
        guard let token=token else{
            cb?(b:false,count:0)
            return
        }

        var  maxid = new ? 0 :(mod.last?.id ?? 0)

        let sinceid = new ? (mod.first?.id ?? 0) : 0
        if maxid > 0 {
            maxid = maxid - 1
        }
        
        HomeDAL.loadHomeData(token, maxid: maxid, sinceid: sinceid, new: new) { (res,suc) -> () in
            guard let res = res else {
                cb?(b:suc,count:0)
                return
            }
            self.cacheImgs(self.dict2Mod(res,new: new),cb: cb,count:res.count,suc:suc)
            
        }
        
    }
    
    
    func cacheImgs(mods:[HomeMod],cb:((b:Bool,count:Int)->())?,count:Int,suc:Bool){
        let group = dispatch_group_create()
        
        for mod in mods{
            let urls0 = mod.retweeted_status?.pic_urls ?? mod.pic_urls
            guard let urls = urls0  where urls .count == 1 else{
                continue
            }
          
            var totalDataLen = 0
            dispatch_group_enter(group)
            SDWebImageDownloader.sharedDownloader().downloadImageWithURL(iUrl(urls[0].thumbnail_pic), options: [], progress: nil, completed: { (img, data, error, flag) -> Void in
                if let img = img ,data = UIImagePNGRepresentation(img){
                    totalDataLen += data.length
                    img.size
                }
                
                dispatch_group_leave(group)
            })
            
            
        }
        
        
        dispatch_group_notify(group, dispatch_get_main_queue()) { () -> Void in
            cb?(b: suc,count: count)
        }
    }
    
    
    

     func dict2Mod(status:[[String:AnyObject]],new:Bool=false)->[HomeMod]{
        var i=0
        var temary=[HomeMod]()
        for val in status {
            let m=HomeMod(dict: val)
            temary.append(m)
            if  ++i >= 4  {
                break
            }
        }
        
        if new{
            self.mod=temary+self.mod
        }else{
            self.mod+=temary
        }
        return temary
        
    }
    
    
}
