







//
//  HomeLab.swift
//  day-43-microblog
//
//  Created by apple on 15/12/18.
//  Copyright © 2015年 yf. All rights reserved.
//

import UIKit

class HomeLab: UILabel {
    
    var reses:[MatchResult]?
    
    var res:MatchResult?
    
    lazy var bgs:[UIView]=[UIView]()

    override var attributedText: NSAttributedString?{
        didSet{
            self.tv.attributedText=attributedText
            self.tv.font=self.font
            
        }
    }
    override func touchesCancelled(touches: Set<UITouch>, withEvent event: UIEvent?) {            self.declickOnRes()

        
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {            self.declickOnRes()

    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        guard let reses=reses else{
            return
        }
        
        
        let trange = tv.characterRangeAtPoint(touches.first!.locationInView(self))
        tv.selectedTextRange=trange
        let srange=tv.selectedRange
        for res in reses{
            if NSLocationInRange(srange.location, res.range!){
                clickOnRes(res)
                break
            }
        }
        
    }
    
    func clickOnRes(res:MatchResult){
//        self.res=res
//      let mastr=NSMutableAttributedString(attributedString: self.attributedText!)
//        mastr.addAttribute(NSBackgroundColorAttributeName, value: iColor(153, g: 186, b: 232), range: res.range!)
//        self.attributedText=mastr
        
        tv.selectedRange=res.range!
        let rects=tv.selectionRectsForRange(tv.selectedTextRange!)
        
        for rect in rects{
            if let rect = rect as? UITextSelectionRect{
                let v =   UIView(frame: rect.rect)
                v.backgroundColor=iColor(153, g: 186, b: 232)
                v.layer.cornerRadius=rect.rect.size.height*0.25
                self.insertSubview(v, atIndex: 0)
                self.bgs.append(v)
            }
        }


    }
    
    func declickOnRes(){
//        guard let res = res else{
//            return
//        }
//        let mastr=NSMutableAttributedString(attributedString: self.attributedText!)
//        mastr.removeAttribute(NSBackgroundColorAttributeName, range: res.range!)
//        self.attributedText=mastr
//        self.res=nil
        
        
        for bg in bgs{
            bg.removeFromSuperview()
        }
        self.bgs.removeAll()
        
    }
    
    
    override
    init(frame: CGRect) {
        super.init(frame: frame)
        userInteractionEnabled=true
        addSubview(tv)
        tv.backgroundColor=UIColor.clearColor()
        tv.snp_makeConstraints { (make) -> Void in
            make.edges.equalTo(0)
        }
        tv.userInteractionEnabled=false
        tv.editable=false
        tv.scrollEnabled=false
        tv.alpha=0
        tv.textContainerInset=UIEdgeInsetsMake(0, -5, 0,-5)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var tv:UITextView=UITextView()
}
