


//
//  PopVC01.swift
//  day-43-microblog
//
//  Created by apple on 15/12/12.
//  Copyright © 2015年 yf. All rights reserved.
//

import UIKit
import SVProgressHUD


class PopVC01: UIViewController {

    var isEmoKB:Bool=false{
        didSet{
           let b = self.toolbar.viewWithTag(ToolbarType.emotion.rawValue) as! UIButton
            var str="compose_emoticonbutton_background"
            if isEmoKB {
                str="compose_keyboardbutton_background"
            }
            b.setImage(iimg(str), forState: UIControlState.Normal)
            b.setImage(iimg("\(str)_highlighted"), forState: UIControlState.Highlighted)
        }
    }
    
    
    private lazy var tv:CustTV={
        let tv=CustTV(frame: self.view.bounds)
        tv.placeholder="input your content"
        tv.delegate=self
         tv.alwaysBounceVertical=true
        tv.font=iFont(20)
        return tv
    }()
  
    private lazy var send:UIButton={
        let b = UIButton(frame:CGRectMake(0, 0, 50, 33),  title: "send", font: iFont(18), titleColor: UIColor.whiteColor(),  bgimg: iimg("common_button_orange")?.stretch(), hlbgimg: iimg("common_button_orange_highlighted")?.stretch(), tar: nil, action: "")
        b.setBackgroundImage(iimg("common_button_white_disable")?.stretch(), forState: UIControlState.Disabled)
        b.setTitleColor(UIColor.grayColor(), forState: UIControlState.Disabled)
        b.addTarget(self, action: #selector(PopVC01.sendBlog), forControlEvents: UIControlEvents.TouchUpInside)
        return b
        
        
    }()
    
    
    private lazy var titleLab:UILabel={
        let l=UILabel(frame: CGRectMake(0, 0, 0, 0), align: NSTextAlignment.Center, line: 0)
       let mastr = NSMutableAttributedString(string: "发微博\n", attributes: [NSFontAttributeName:iFont(18),NSForegroundColorAttributeName:UIColor.blackColor()])
        if let name=UserInfo.me?.screen_name{
            mastr.appendAttributedString(NSAttributedString(string: name, attributes: [NSFontAttributeName:iFont(15),NSForegroundColorAttributeName:UIColor.grayColor()]))
        }
        l.attributedText=mastr
        
        l.sizeToFit()
        return l
    }()
    
    
    private lazy var toolbar:BGStackV={
        let tb=BGStackV(frame: CGRectMake(0, self.view.h-44-iTopBarH, self.view.w, 44))
        tb.backgroundColor=iGlobalBG
        
        let newb={(img:String,tag:Int)->UIButton in
            return UIButton( img: iimg(img), hlimg: iimg("\(img)_highlighted"),bgcolor:UIColor(patternImage: iimg("compose_toolbar_background")!),  tar: self, action: #selector(PopVC01.onToolBarItemClicked(_:)),tag:tag)
            
        }
        let ary=["compose_toolbar_picture","compose_mentionbutton_background","compose_trendbutton_background","compose_emoticonbutton_background","compose_pic_add"]
     
        for (i,str) in ary.enumerate(){
            tb.addArrangedSubview(newb(str,i))
        }
        return tb
    
    }()
    
    private lazy var imgcv:PostBlogImgCV={
        let cv=PostBlogImgCV(frame: CGRectMake(10, 100, self.tv.w-20, self.tv.w-20))
        cv.backgroundColor=self.tv.backgroundColor
        return cv
    }()
    
    
    private lazy var emokb:EmoKB={
        let emokb=EmoKB(frame: CGRectMake(0,0,self.view.w,220))

        return emokb
        
    }()
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.view.backgroundColor=irandColor()
        self.navigationItem.leftBarButtonItem=UIBarButtonItem(title: "back", style: UIBarButtonItemStyle.Done, target: self, action: #selector(PopVC01.dismiss))
        self.navigationItem.rightBarButtonItem=UIBarButtonItem(customView: self.send)
        self.navigationItem.rightBarButtonItem?.enabled=false
        self.navigationItem.titleView=self.titleLab
        self.view.addSubview(tv)
        view.addSubview(toolbar)
        tv.addSubview(self.imgcv)
        imgcv.cb={
            [weak self] in
            self?.selectPic()
        }
        
        iNotiCenter.addObserver(self, selector: #selector(PopVC01.onKBChange(_:)), name: UIKeyboardWillChangeFrameNotification, object: nil)
        iNotiCenter.addObserver(self, selector: #selector(PopVC01.onEmoClick(_:)), name: iConst.EmoClickNoti, object: nil)
        iNotiCenter.addObserver(self, selector: #selector(PopVC01.onEmoDelClick(_:)), name: iConst.EmoDelClickNoti, object: nil)
        
        
//        tv.userInteractionEnabled=false
    }
    
    deinit{
        iNotiCenter.removeObserver(self)
    }
    
   
    
}

//funcs
extension PopVC01{
    func onKBChange(noti:NSNotification){
        
        if var kby = noti.userInfo!["UIKeyboardFrameEndUserInfoKey"]?.CGRectValue.origin.y{
            kby -= iTopBarH
            if self.toolbar.tag == 2 {
                self.toolbar.b=kby
            }else if self.toolbar.tag==0{
                UIView.animateKeyframesWithDuration(noti.userInfo!["UIKeyboardAnimationDurationUserInfoKey"]!.doubleValue, delay: 0, options: [], animations: { () -> Void in
                    self.toolbar.b=kby
                    }, completion: { (_) -> Void in
                        
                })
            }
        }
        self.toolbar.tag=0
    }
    
    
    func sendBlog(){
        MainVM.postBlog(self.tv.emoTxt, imgs: self.imgcv.imgs) { (suc) -> () in
            if suc{
                iPop.showSuc("success!")
            }else{
                iPop.showError("fail!")
            }
        }
        
    }
    
    
    func onEmoDelClick(noti:NSNotification){
        tv.deleteBackward()
    }
    
    func onEmoClick(noti:NSNotification){
        guard let emo = noti.object as? Emoticon else{
            return
        }
        EmoticonTool.inst.saveRecent(emo)
        tv.insertEmo(emo)
        
    }
    
    
    func dismiss(){
        self.view.endEditing(true)
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    

}


//delegate
extension  PopVC01:UINavigationControllerDelegate,UITextViewDelegate,UIImagePickerControllerDelegate{
     func textViewDidChange(textView: UITextView){
        send.enabled=tv.text.len>0
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        if scrollView.dragging{
            self.view.endEditing(true)
        }
    }
    
    func onToolBarItemClicked(btn:UIButton){
        let tag = ToolbarType(rawValue: btn.tag)!
        
        switch tag {
        case .picture:
            
            selectPic()
      
        case .mention:
            print("mention")
            
            
        case .trend:
            print("trend")
            
        case .emotion:
            
//            if !self.tv.isFirstResponder(){
//                self.tv.becomeFirstResponder()
//                return
//            }

            self.toolbar.tag=1
            self.tv.resignFirstResponder()
            if tv.inputView != nil{
                 self.tv.inputView=nil
            }else{
                self.tv.inputView=emokb
            }
            self.isEmoKB=self.tv.inputView != nil
           
            self.toolbar.tag=2
            self.tv.becomeFirstResponder()
            
        case .add:
            print("add")
            
        }
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]){
        let img=info["UIImagePickerControllerOriginalImage"] as! UIImage
        picker.dismissViewControllerAnimated(true, completion: nil)
        if imgcv.imgs.count>=9{
            iPop.showMsg("无法继续添加")
        }else{
            imgcv.addImg(img.scale2w(200))
        }

    }

    func imagePickerControllerDidCancel(picker: UIImagePickerController){
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    func selectPic() {
        let vc = UIImagePickerController()
        vc.delegate=self
        let res=UIImagePickerController.isSourceTypeAvailable(.PhotoLibrary)
        if res {
            presentViewController(vc, animated: true, completion: nil)
        }else{
            iPrint("not available")
        }
    }
    
//    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
//        let bund=NSBundle(path: iRes("Emoticons.bundle")!)!
//
//
//        
//        let path = iRes("default/d_chitangyuan@2x.png", bundle:bund)
//        print(path)
//        print(iimg("Emoticons.bundle/Contents/Resources/default/d_chitangyuan.png"))
        

//    }
}


public enum ToolbarType : Int {
    case picture = 0
    case mention = 1
    case trend = 2
    case emotion = 3
    case add = 4
}



