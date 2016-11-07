



//
//  UserInfo.swift
//  day-43-microblog
//
//  Created by apple on 15/12/6.
//  Copyright © 2015年 yf. All rights reserved.
//

import UIKit


class UserInfo: NSObject,NSCoding {
//    static let file="userinfo.archive".strByAp2Doc()
    static let file = iRes("userinfo.archive")!
    static var me:UserInfo?=UserInfo.unarchive()
    
    var welcomed:Bool=false
    var access_token:String?
    var expires_in : Double=0{
        didSet{
            expire=NSDate(timeIntervalSinceNow: expires_in-60)
        }
    }
    var uid : String?
    var avatar_large:String?
    var screen_name:String?
    var expire:NSDate?
    
    private init(dict:[String:AnyObject]) {
        super.init()
        setValuesForKeysWithDictionary(dict)
    }
    private override init(){
        super.init()
    }
    
    
    class func hasWelcomed()->Bool{
        guard let user = me  else{
            return true
        }
        return user.welcomed
    }
    
    class func welcomed(b:Bool){
        if let user=me {
            user.welcomed=b
        }
    }
    class func isLogin()->Bool{
        guard let user = me  else{
            return false
        }
        return user.access_token != nil //&& NSDate().compare(user.expire!) == .OrderedAscending

    }
    class func login(dict:[String:AnyObject]){
        me=UserInfo(dict: dict)
    }
    
    func detail(dict:[String:AnyObject]){
        avatar_large=dict["avatar_large"] as? String
        screen_name=dict["screen_name"] as? String
    }
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
    }
    
    override func valueForUndefinedKey(key: String) -> AnyObject? {
        return 0
    }
    
    override var description:String{
        get{
            return dictionaryWithValuesForKeys(["access_token","expires_in","uid","avatar_large","screen_name","expires"]).description
        }
    }
    
    func archive(){
        print(UserInfo.file)
        NSKeyedArchiver.archiveRootObject(self, toFile: UserInfo.file)
    }
    private class func unarchive()->UserInfo?{
        return NSKeyedUnarchiver.unarchiveObjectWithFile(UserInfo.file) as? UserInfo
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(access_token, forKey: "access_token")
        aCoder.encodeDouble(expires_in, forKey: "expires_in")
        aCoder.encodeObject(expire, forKey: "expire")
        aCoder.encodeObject(uid, forKey: "uid")
        aCoder.encodeObject(avatar_large, forKey: "avatar_large")
        aCoder.encodeObject(screen_name, forKey: "screen_name")
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init()
        access_token=aDecoder.decodeObjectForKey("access_token") as? String
        expires_in=aDecoder.decodeDoubleForKey("expires_in")
        expire=aDecoder.decodeObjectForKey("expire") as? NSDate
        uid=aDecoder.decodeObjectForKey("uid") as? String
        avatar_large=aDecoder.decodeObjectForKey("avatar_large") as? String
        screen_name=aDecoder.decodeObjectForKey("screen_name") as? String
        
    }
    
   
}



//sina login
extension UserInfo{
    @nonobjc static let App_Key = "1449069583"
    @nonobjc static let App_Secret = "6815369cb7df3d42766e68a163e7dda9"
    
    @nonobjc static let Auth_url="https://api.weibo.com/oauth2/authorize?client_id=%@&redirect_uri=%@"
    @nonobjc static let Token_url="https://api.weibo.com/oauth2/access_token"
    @nonobjc static let User_Url="https://api.weibo.com/2/users/show.json"
    
    @nonobjc static let CB_url="http://www.itheima.com/"
    
    
    class func requestToken(code:String,cb:((suc:Bool)->())?){
        
       
            let dict=["client_id":App_Key,"client_secret":App_Secret,"gran_type":"authorization_code","code":code,"redirect_uri":CB_url]
            //            INet.post(iUrl(Token_url), body: INet.dict2str(dict), cb: { (data, resp, err) -> () in
            //                guard let da=data else{
            //                    return
            //                }
            //                do{
            //                    let val=try NSJSONSerialization.JSONObjectWithData(da, options: [])
            //                    UserInfo.login(val as! [String : AnyObject])
            //                    print(UserInfo.me ?? "")
            //                }catch{
            //                    print(error)
            //                }
            //            })
            
            INet.requestJson(false, url: Token_url, para: dict, cb: { (dict) -> () in
                UserInfo.login(dict as! [String:AnyObject])
                requestUser(cb)
            })

       
    }
    
    class func requestUser(cb:((suc:Bool)->())?){
        guard let userinfo=UserInfo.me else{
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                cb?(suc: false)
            })
         
            return
        }
        
        let dict:[String:AnyObject]=[
            
            "uid":userinfo.uid!,
            "access_token":userinfo.access_token!
        ]

        INet.requestJson(true, url: User_Url, para: dict,cb:{ (dict) -> () in
            
            userinfo.detail(dict as! [String : AnyObject])
            userinfo.archive()
            print(UserInfo.me)
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                cb?(suc: true)
            })
            },fail: {(err,resp)->()in
                print(err)
        })
    }
    
}

