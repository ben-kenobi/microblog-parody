







//
//  EmoKB.swift
//  day-43-microblog
//
//  Created by apple on 15/12/15.
//  Copyright © 2015年 yf. All rights reserved.
//

import UIKit

class EmoKB: UIView {

    let celliden="celliden"
    
    lazy var chooser:BGStackV={
        let cho=BGStackV(frame: CGRectMake(0, self.h-44, self.w, 44))
        let newb={
            (title:String,img:String,tag:Int)->UIButton in
            let b =  UIButton( title: title, font: iFont(18), titleColor: UIColor.whiteColor(), bgimg: iimg("\(img)_normal")?.stretch(),  tar: self, action: #selector(EmoKB.chooseChange(_:)), tag: 0)
             b.setBackgroundImage(iimg("\(img)_selected")?.stretch(), forState: UIControlState.Selected)
             b.setTitleColor(UIColor.grayColor(), forState: UIControlState.Selected)
            b.tag=tag
            return b
        }
        
        cho.addArrangedSubview(newb("最近","compose_emotion_table_left",1))
        cho.addArrangedSubview(newb("默认","compose_emotion_table_mid",2))
        cho.addArrangedSubview(newb("emoji","compose_emotion_table_mid",3))
        cho.addArrangedSubview(newb("浪小花","compose_emotion_table_right",4))
        
        return cho
    
    }()
    
    
    lazy var cv:UICollectionView={
        let lo = UICollectionViewFlowLayout()
        lo.minimumInteritemSpacing=0
        lo.minimumLineSpacing=0
        lo.scrollDirection = .Horizontal
        lo.sectionInset=UIEdgeInsetsMake(0,0,0,0)
        let cv=UICollectionView(frame: CGRectMake(0, 0, self.w, self.h-44), collectionViewLayout: lo)
        cv.dataSource=self
        cv.delegate=self
        lo.itemSize=CGSizeMake(cv.w,cv.h)
        cv.bounces=false
        cv.showsHorizontalScrollIndicator=false
       cv.registerClass(EmoKBCell.self, forCellWithReuseIdentifier: self.celliden)
        cv.pagingEnabled=true
        cv.backgroundColor=UIColor.clearColor()
        return cv
    }()
    
    lazy var pc:UIPageControl={
       let pc = UIPageControl()
        pc.userInteractionEnabled=false

        pc.setValue(iimg("compose_keyboard_dot_normal"), forKeyPath: "_pageImage")
        pc.setValue(iimg("compose_keyboard_dot_selected"), forKeyPath: "_currentPageImage")
        
      
        return pc
    }()
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
       addSubview(chooser)
        chooseChange(chooser.viewWithTag(2) as! UIButton)
       addSubview(cv)
        addSubview(pc)
        pc.snp_makeConstraints { (make) -> Void in
            make.centerX.equalTo(0)
            make.bottom.equalTo(chooser.snp_top)
            make.height.equalTo(20)
        }

    }

   
    
    
}


extension EmoKB:UICollectionViewDataSource,UICollectionViewDelegate{
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int{
            return EmoticonTool.inst.emoticons.count
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return EmoticonTool.inst.emoticons[section].count
    }
    
   
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell{
        let cell=collectionView.dequeueReusableCellWithReuseIdentifier(celliden, forIndexPath: indexPath) as! EmoKBCell
        cell.idx=indexPath
        cell.datas=EmoticonTool.inst.emoticons[indexPath.section][indexPath.row]
        return cell
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView){
        
        choose(self.cv.indexPathForItemAtPoint(CGPointMake(scrollView.contentOffset.x+scrollView.w*0.5,0))!)
        
//        choose(idxPath(Int(scrollView.contentOffset.x/scrollView.w+1.5)))
    }
}

extension EmoKB{
//   
//    func idxPath(idx:Int)->NSIndexPath{
//        var section = -1
//        var row = -1
//        var idx=idx
//        for val in EmoticonTool.inst.emoticons{
//            if idx==0{
//                break
//            }
//            section++
//            row = -1
//            for _ in val{
//                if idx==0{
//                    break
//                }
//                row++
//                idx--
//            }
//        }
//        return NSIndexPath.init(forRow: row, inSection: section)
//    }
    
    func choose(idx:NSIndexPath)->Bool{
         pc.currentPage=idx.row
        guard let b = self.chooser.viewWithTag(idx.section+1) as? UIButton else{
            return false
        }
        
        if b.selected{
            return false
        }
        for v in self.chooser.subviews{
            if let b=v as? UIButton{
                b.selected=false
            }
        }
        pc.numberOfPages =  EmoticonTool.inst.emoticons[idx.section].count
        pc.currentPage=idx.row
        b.selected=true
        pc.hidden=idx.section==0
        return true
    }
    
    func chooseChange(b:UIButton){
       
        if b.selected{
            return
        }
        
        
        switch EmoType(rawValue:b.tag)!{

        case .recent:
            print("recent")

        case .defau:
            print("defau")

        case .emoji:
            print("emoji")

        case .lxh:
            print("lxh")
        }
        self.cv.scrollToItemAtIndexPath(NSIndexPath.init(forRow: 0, inSection: b.tag-1), atScrollPosition: UICollectionViewScrollPosition.None, animated: false)
        
    }
    
    
}



public enum EmoType : Int {
    case recent = 1
    case defau = 2
    case emoji = 3
    case lxh = 4
}
