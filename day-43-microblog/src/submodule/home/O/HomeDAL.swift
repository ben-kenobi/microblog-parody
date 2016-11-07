
//
//  HomeDAL.swift
//  day-43-microblog
//
//  Created by apple on 15/12/21.
//  Copyright © 2015年 yf. All rights reserved.
//

import UIKit

class HomeDAL {
    
    private static let persistSec:NSTimeInterval=60
    
    class func clearStatusTable(){
        let  sql = "delete from t_status where createtime < ? ;"
        FMDBMan.ins.queue.inTransaction { (db, rb) -> Void in
            if db.executeUpdate(sql, NSDate(timeIntervalSinceNow: -persistSec).timeFM()){
                iCommonLog("delete \(db.changes()) items")
            }else{
                rb.memory=true
            }
        }
    }
    
    
    class func loadHomeData(token:String,maxid:Int64,sinceid:Int64,new:Bool,cb:(res:[[String:AnyObject]]?,suc:Bool)->()){
        let status = getCacheDatas(maxid, sinceid: sinceid)
        if status.count>3{
            cb(res: status,suc: true)
            return
        }
        let dict:[String:AnyObject]=["access_token":token,"max_id":"\(maxid>0 ? maxid : 0)",
            "since_id":"\(sinceid)"]
        
        let url = "https://api.weibo.com/2/statuses/friends_timeline.json"
        
//        INet.requestJson(true, url: "http://localhost/aa.txt", para: dict, cb: { (datas) -> () in                 
        INet.requestJson(true, url: url, para: dict, cb: { (datas) -> () in
            guard let res=datas as? [String:AnyObject] else{
                print("not a valid data")
                cb(res:nil,suc:false)
                return
            }
            
            
            guard let status=res["statuses"] as? [[String:AnyObject]] else{
                print("no statuses")
                cb(res:nil,suc:true)
                return
            }
            self.saveData(status)
            cb(res: status,suc:true)
            
            }) { (err, resp) -> () in
                cb(res:nil,suc:false)
                
        }
        
        
    }
    
    
    class func getCacheDatas(maxid:Int64,sinceid:Int64)->[[String:AnyObject]]{
        
        var sql = "select _id,uid,status from t_status where uid=\(UserInfo.me!.uid!) \n"
        if maxid>0 {
            sql += " and _id <= \(maxid)"
        }else if sinceid > 0 {
            sql += " and _id > \(sinceid)"
        }
        sql += " order by _id desc limit 20;"
//        iCommonLog(sql)
        var temp = [[String:AnyObject]]()
        let status = FMDBMan.ins.query(sql)
        for  dict in status{
            var data = dict["status"] as? NSData
            if data == nil{
                data = (dict["status"] as! String).dataUsingEncoding(4)
            }
            temp.append(try! NSJSONSerialization.JSONObjectWithData(data!, options: []) as![String:AnyObject] )
            
        }
        return temp

    }

   class func saveData(status:[[String:AnyObject]]){
        FMDBMan.ins.queue.inTransaction { (db, rb) -> Void in
            for dict in status{
              
                db.executeUpdate("insert or replace into t_status (_id,uid,status) values (?,?,?);", dict["id"] as! NSNumber,UserInfo.me!.uid!,try! NSJSONSerialization.dataWithJSONObject(dict, options: []))
            }
        }
    }
    
    class func cacheImg(url:String){

    }
    
    
    
   
}
