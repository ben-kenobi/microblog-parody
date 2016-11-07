
//
//  BlogPics.swift
//  day-43-microblog
//
//  Created by apple on 15/12/11.
//  Copyright © 2015年 yf. All rights reserved.
//

import UIKit

class BlogPics: NSObject {

    var thumbnail_pic:String?
    
    init(dict:[String:AnyObject]) {
        super.init()
        setValuesForKeysWithDictionary(dict)
    }
    
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
    }
    
    override var description:String{
        return thumbnail_pic ?? ""
    }
    
}
