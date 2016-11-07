
//
//  Aoo.swift
//  day-43-microblog
//
//  Created by apple on 15/12/8.
//  Copyright © 2015年 yf. All rights reserved.
//

import UIKit

class Aoo: NSObject , NSCoding{
    
    static var file="aoo.plist".strByAp2Doc()
    
    var name:String?
    var sec:Double=0{
        didSet{
           expire=NSDate(timeIntervalSinceNow: sec)
            print("expire=\(expire)")
        }
    }
    
    var expire:NSDate?{
        didSet{
            print(expire)
        }
        
    }
    
    override var description:String{
        get{
            return dictionaryWithValuesForKeys(["name","sec","expire"]).description
        }
    }
    
    init(dict:[String:AnyObject]) {
        super.init()
        setValuesForKeysWithDictionary(dict)
        print(Aoo.file)

    }
    class func unarc()->Aoo?{
       return  NSKeyedUnarchiver.unarchiveObjectWithFile(file) as? Aoo
    }
    func arc(){
        NSKeyedArchiver.archiveRootObject(self, toFile: Aoo.file)
    }
    
    
    func encodeWithCoder(aCoder: NSCoder){
        aCoder.encodeObject(name, forKey: "name")
        aCoder.encodeDouble(sec, forKey: "sec")
        aCoder.encodeObject(expire, forKey: "expire")
    }
    required init?(coder aDecoder: NSCoder){
        super.init()
        setValue(aDecoder.decodeObjectForKey("name") as? String, forKeyPath: "name")
        setValue(aDecoder.decodeDoubleForKey("sec"), forKeyPath: "sec")
        setValue(aDecoder.decodeObjectForKey("expire") as? NSDate, forKeyPath: "expire")

    }
}
