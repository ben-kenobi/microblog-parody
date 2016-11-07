

//
//  HomeMod.swift
//  day-43-microblog
//
//  Created by apple on 15/12/9.
//  Copyright © 2015年 yf. All rights reserved.
//

import UIKit

class HomeMod: NSObject {
    
    var id:Int64?
    
    // 微博的内容
    var text: String?{
        didSet{
            text = (text ?? "") + "[哈哈][哈哈][哈哈][哈哈][哈哈]"
        }
    }
    // 当前微博作者信息
    var user: BlogUser?
    // 微博的创建时间
    var created_at: String?
    // 来自
    var source: String?
    // 转发
    var reposts_count: Int = 0
    // 评论数
    var comments_count: Int = 0
    // 表态数
    var attitudes_count: Int = 0
    // 转发微博的内容
    var retweeted_status: HomeMod?
    var pic_urls:[BlogPics]?{
        didSet{
//            if(pic_urls?.count>4){
//                var pics=[BlogPics]()
//                for i in 0...3{
//                    pics.append(pic_urls![i])
//                }
//                pic_urls=pics
            
//            }
        }
    }
    
    init(dict:[String:AnyObject]) {
        super.init()
        setValuesForKeysWithDictionary(dict)
        
    }
    
    override func setValue(value: AnyObject?, forKey key: String) {
        if key=="user"{
            if let dict = value as? [String:AnyObject]{
                user=BlogUser(dict:dict)
            }
        }else if key=="retweeted_status"{
            if let dict = value as? [String:AnyObject]{
                retweeted_status=HomeMod(dict: dict)
            }
        }else if key=="pic_urls"{
            if let ary = value as? [[String:AnyObject]]{
                pic_urls=[BlogPics]()
                for dict in ary{
                    pic_urls?.append(BlogPics(dict:dict))
                }
            }
        }else if key == "id"{
            id = Int64(value!.longLongValue)
        }else{
            super.setValue(value, forKey: key)
            
        }
        
        
    }
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {

    }
    
    lazy var attRes:(atr:NSAttributedString?,reses:[MatchResult]?) = EmoticonTool.inst.emoAttStrFromStr(self.text)
    lazy var retAttRes:(atr:NSAttributedString?,reses:[MatchResult]?) = EmoticonTool.inst.emoAttStrFromStr(self.retwTxt)
}



extension HomeMod{
    
    var vipImg:UIImage?{
        guard let rank = user?.mbrank else {
            return nil
        }
        if rank > 0 && rank < 7 {
            return UIImage(named: "common_icon_membership_level\(rank)")
        }
        return nil
    }
    
    var veriImg:UIImage?{
        guard let veri=user?.verified else{
            return nil
        }
        var img:UIImage?=nil
        switch veri{
        case 1:
            img=iimg("avatar_vip")
            break
        case 2,3,5:
            img=iimg("avatar_enterprise_vip")
            break
        case 220:
            img=iimg("avatar_grassroot")
            break
        default:
            break
        }
        return img
    }
    
    private func countStr(count:Int,def:String)->String{
        if count>=10000{
            let f=CGFloat(count/1000)*0.1
            return  f-CGFloat(Int(f)) > 0 ? "\(f)万" : "\(Int(f))万"
        }else if count>0{
            return "\(count)"
        }else{
            return def
        }
    }
    
    
    var retwCount:String{
        return countStr(reposts_count, def: "转发")
    }
    var commentCount:String{
        return countStr(comments_count, def: "评论")
    }
    var attitudeCount:String{
        return countStr(attitudes_count, def: "赞")
    }
    var sourceTxt:String{
        
        if let src=source where src.containsString("\">") && src.containsString("</"){
            return src.substringWithRange(src.rangeOfString("\">")!.endIndex..<src.rangeOfString("</")!.startIndex)
            
        }

        return ""
    }
    
    var postTime:String{
        
        guard let date=NSDate.time4FromStr(created_at) else{
            return ""
        }
        return date.formatBlogTime()
    }
    
    var retwTxt:String{
        return "@\(user?.name ?? ""): \(text ?? "")"
    }
    
    
    
}

















