


//
//  Emoticon.swift
//  day-43-microblog
//
//  Created by apple on 15/12/15.
//  Copyright © 2015年 yf. All rights reserved.
//

import UIKit

class Emoticon: NSObject,NSCoding {
    
//    let emobundlePrefix="Emoticons.bundle/Contents/Resources/"
    var chs:String?
    var png:String?
    
    //0:normal  1:emoji
    var type:String?
    
    //emoji's code
    var code:String?
    

    var path:String?{
        didSet{
            if isEmoji {
                path=code!.emoji()
            }else if path != nil{
                
//                path=emobundlePrefix+path! + "/" + (png ?? "")
                path=path! + "/" + (png ?? "")

            }
        }
    }
    
    var isEmoji:Bool{
        return type=="1"
    }
    
    var emoImg:UIImage?{
//        return  iimg(path)
        return UIImage(named: path ?? "", inBundle: EmoticonTool.inst.bund, compatibleWithTraitCollection: nil)
    }
    
    
    
    
    init(dict:[String:AnyObject]) {
        super.init()
        setValuesForKeysWithDictionary(dict)
    }
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
    }
    
    override var description:String{
        get{
            return "{type:\(type),code:\(code),chs:\(chs)}"
        }
    }
    
    
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(chs, forKey: "chs")
        aCoder.encodeObject(png, forKey: "png")
        aCoder.encodeObject(type, forKey: "type")
        aCoder.encodeObject(code, forKey: "code")
        aCoder.encodeObject(path, forKey: "path")
    }
    
    required init?(coder aDecoder: NSCoder) {
        chs = aDecoder.decodeObjectForKey("chs") as? String
        png = aDecoder.decodeObjectForKey("png") as? String
        type = aDecoder.decodeObjectForKey("type") as? String
        code = aDecoder.decodeObjectForKey("code") as? String
        path = aDecoder.decodeObjectForKey("path") as? String

    }
    
    
    override func isEqual(object: AnyObject?) -> Bool {

        guard let obj = object as? Emoticon else{
            return super.isEqual(object)
        }
        
        
        if isEmoji == obj.isEmoji{
            return isEmoji ?  (code! as NSString).isEqualToString(obj.code!) : (chs! as NSString).isEqualToString(obj.chs!)
           
        }else {
            return super.isEqual(obj)
        }
    }
}
