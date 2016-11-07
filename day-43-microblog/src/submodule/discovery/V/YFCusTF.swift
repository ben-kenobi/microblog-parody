


//
//  YFCusTF.swift
//  day-43-microblog
//
//  Created by apple on 15/12/5.
//  Copyright © 2015年 yf. All rights reserved.
//

import UIKit

class YFCusTF: UIView,UITextFieldDelegate {
    var tf:UITextField?
    var btn:UIButton?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
       
        
        btn=UIButton(frame: CGRect(x: self.w-80, y: 0, width: 80, height: self.h))
        addSubview(btn!)
        btn?.setTitle("cancel", forState: UIControlState.Normal)
        btn?.setTitleColor(UIColor.orangeColor(), forState: UIControlState.Normal)
        btn?.setTitleColor(UIColor.lightGrayColor(), forState: UIControlState.Highlighted)
        
        
        tf=UITextField(frame: frame)
        tf?.backgroundColor=UIColor.whiteColor()
        addSubview(tf!)
        tf?.layer.cornerRadius=3
        tf?.layer.borderColor=UIColor.grayColor().CGColor
        tf?.layer.borderWidth=1
        tf?.placeholder="enter your text"
        
        tf?.leftView=UIView(frame: CGRect(x: 0, y: 0, width: 30, height: self.h))
        tf?.leftViewMode = .Always
        tf?.delegate=self
        let iv=UIImageView(image: UIImage(named: "searchbar_textfield_search_icon"))
        iv.center=tf!.leftView!.ic
        tf?.leftView!.addSubview(iv)
        
        btn?.addTarget(tf, action: #selector(UIResponder.resignFirstResponder), forControlEvents: UIControlEvents.TouchUpInside)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func textFieldDidBeginEditing(textField: UITextField){
        UIView.animateWithDuration(0.25) { () -> Void in
            self.tf?.w=self.w-self.btn!.w
        }

    }
    
    func textFieldDidEndEditing(textField: UITextField){
        UIView.animateWithDuration(0.25) { () -> Void in
            self.tf?.w=self.w
        }
    }
    

}
