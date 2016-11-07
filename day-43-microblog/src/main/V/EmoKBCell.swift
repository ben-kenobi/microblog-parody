



//
//  EmoKBCell.swift
//  day-43-microblog
//
//  Created by apple on 15/12/15.
//  Copyright © 2015年 yf. All rights reserved.
//

import UIKit

class EmoKBCell: UICollectionViewCell {
    let celliden="celliden"

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(lab)
        contentView.addSubview(cv)
        cv.registerClass(EmoCell.self, forCellWithReuseIdentifier: celliden)
        contentView.addSubview(delBtn)
        
        cv.addGestureRecognizer(UILongPressGestureRecognizer(target: self, action: #selector(EmoKBCell.onLp(_:))))
    }
    
    lazy var popv:EmoPopV=EmoPopV(frame:CGRectMake(0,0, self.w/7+30,self.w/7*2.3))
    
    var datas:[Emoticon]?{
        didSet{
            self.cv.reloadData()
        }
    }
    var idx:NSIndexPath?{
        didSet{
            self.lab.hidden=idx?.section != 0
        }
    }
    
    
    private lazy var cv:UICollectionView={
        let lo = UICollectionViewFlowLayout()
        lo.itemSize=CGSizeMake(self.w/7,self.h/3)
        lo.minimumInteritemSpacing=0
        lo.minimumLineSpacing=0
        let cv=UICollectionView(frame: self.bounds, collectionViewLayout: lo)
        cv.delegate=self
        cv.dataSource=self
        cv.backgroundColor=UIColor.clearColor()
        return cv
    }()
    
    private lazy var delBtn:UIButton=UIButton(frame: CGRectMake(self.w/7*6, self.h/3*2, self.w/7,self.h/3), img: iimg("compose_emotion_delete_highlighted"), hlimg: iimg("compose_emotion_delete"),  tar: self, action: #selector(EmoKBCell.ondel))
   
    private lazy var lab:UILabel=UILabel(frame: CGRectMake(0, self.h-30, self.w, 30), txt: "最近使用表情", color: UIColor.grayColor(), font: iFont(18), align: NSTextAlignment.Center, line: 0)

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension EmoKBCell :UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return  self.datas?.count ?? 0
    }
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell{
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(celliden, forIndexPath: indexPath) as! EmoCell
        if(self.datas!.count <= indexPath.row){
            cell.emo=nil
        }else{
            cell.emo=self.datas![indexPath.row]
        }

        return cell
    }
    
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let emo=self.datas![indexPath.row]
        iNotiCenter.postNotificationName(iConst.EmoClickNoti, object: emo, userInfo: nil)
        
        let cell=collectionView.cellForItemAtIndexPath(indexPath) as! EmoCell
        cell.showPop(popv)
        
       idelay(0.1, asy: false) { () -> () in
            self.popv.removeFromSuperview()
        }
    }
    
    func ondel(){
        iNotiCenter.postNotificationName(iConst.EmoDelClickNoti, object: nil, userInfo: nil)
    }
    
    func onLp(lp:UILongPressGestureRecognizer){
        
        if lp.state == .Cancelled{
            
            popv.removeFromSuperview()
            return
        }
        
        guard let idx = self.cv.indexPathForItemAtPoint(lp.locationInView(self.cv)) else{
            popv.removeFromSuperview()
            return
        }
        
        if lp.state == .Ended{
            collectionView(cv, didSelectItemAtIndexPath: idx)
            return
        }
        let cell = self.cv.cellForItemAtIndexPath(idx) as! EmoCell
        cell.showPop(popv)
       
    }
}



class EmoCell:UICollectionViewCell{
    
    
    var emo:Emoticon?{
        set{
            btn.emo=newValue
        }
        get{
            return btn.emo
        }
    }
    func showPop(popv:EmoPopV){
        if popv.superview == nil{
            iApp.windows.last?.addSubview(popv)
        }
        let p = self.convertPoint(CGPointMake(self.icx, self.h), toView: nil)
        
        popv.b=p.y
        popv.cx=p.x
        
        popv.emo = emo
    }
    
    lazy var btn:EmoButton=EmoButton(frame: self.bounds, font: iFont(33), action: "")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(btn)
        btn.userInteractionEnabled=false
    }

    
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
       
}





class EmoPopV:UIView{
    lazy var btn:EmoButton=EmoButton(font: iFont(33), action: "")
    
    
    var emo:Emoticon?{
        set{
            btn.emo=newValue
        }
        get{
            return btn.emo
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let iv=UIImageView()
        iv.image=iimg("emoticon_keyboard_magnifier")?.stretch()
        addSubview(iv)
        iv.snp_makeConstraints { (make) -> Void in
            make.edges.equalTo(0)
        }
        
        
        addSubview(btn)
        btn.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(0)
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.bottom.equalTo(snp_centerY).offset(15)
        }
        btn.setImage(iimg("compose_emotion_delete"), forState: UIControlState.Normal)
    }
    
    
    
    
    

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


class EmoButton:UIButton{
    var emo:Emoticon?{
        didSet{
            if emo == nil{
                //                btn.setImage(iimg("compose_emotion_delete_highlighted"), forState: UIControlState.Normal)
                //                btn.setTitle(nil, forState: UIControlState.Normal)
            }else{
                if emo!.isEmoji{
                    self.setTitle(emo?.path, forState: UIControlState.Normal)
                    self.setImage(nil, forState: .Normal)
                }else{
                    self.setImage(emo?.emoImg, forState: UIControlState.Normal)
                    self.setTitle(nil, forState: .Normal)
                }
            }
        }
    }
}
