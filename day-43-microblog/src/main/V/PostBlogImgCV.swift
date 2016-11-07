//
//  PostBlogImgCV.swift
//  day-43-microblog
//
//  Created by apple on 15/12/14.
//  Copyright © 2015年 yf. All rights reserved.
//

import UIKit

class PostBlogImgCV: UICollectionView {
    
    
    lazy var imgs:[UIImage]=Array()
    
    lazy var ondele:((tag:Int)->())={
        [weak self](tag:Int)->() in
        self?.imgs.removeAtIndex(tag)
        self?.reloadData()
       self?.hidden=self?.imgs.count==0
    }
    
    var cb:(()->())?
    
    let celliden="PostBlogImgCVcelliden"
    init(frame: CGRect) {
        let pad:CGFloat=5
        let lo = UICollectionViewFlowLayout()
        lo.minimumInteritemSpacing=pad
        lo.minimumLineSpacing=pad
        lo.sectionInset=UIEdgeInsetsZero
        super.init(frame: frame, collectionViewLayout: lo)
        lo.itemSize=CGSizeMake((w-pad*2)/3, (w-pad*2)/3)
        delegate=self
        dataSource=self
        registerClass(PostBlogImgCVCell.self, forCellWithReuseIdentifier: celliden)
        self.hidden=true
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}


extension PostBlogImgCV{
    func addImg(img:UIImage){
        imgs.append(img)
        print(img.size)
        reloadData()
        self.hidden=self.imgs.count==0
    }
}



extension PostBlogImgCV:UICollectionViewDataSource,UICollectionViewDelegate {
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return imgs.count==0||imgs.count==9 ? imgs.count : imgs.count+1
    }
   
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell{
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(celliden, forIndexPath: indexPath) as! PostBlogImgCVCell
        if indexPath.row > imgs.count-1{
            cell.img=nil
        }else{
            cell.img=imgs[indexPath.row]
        }
        cell.tag=indexPath.row
        cell.cb=ondele
        return cell
    }
    
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath){
        deselectItemAtIndexPath(indexPath, animated: true)
        if(indexPath.row==imgs.count){
            cb?()
        }
    }

}




class PostBlogImgCVCell:UICollectionViewCell{
    
    private lazy var iv:UIImageView=UIImageView(frame: self.bounds)
    private lazy var btn:UIButton = {
        let btnw:CGFloat=30
        let b = UIButton(frame: CGRectMake(self.w-btnw,0, btnw, btnw), img: iimg("compose_photo_close"),  tar: self, action: #selector(PostBlogImgCVCell.onClicked(_:)), tag: 0)
        return b
    }()
    
    var img:UIImage?{
        didSet{
            if img==nil{
                iv.image=iimg("compose_pic_add")
                iv.highlightedImage=iimg("compose_pic_add_highlighted")
                self.btn.hidden=true
            }else{
                iv.image=img
                iv.highlightedImage=nil
                self.btn.hidden=false
            }
            
        }
    }
    
    var cb:((tag:Int)->())?
    
    
    func onClicked(b:UIButton){
        cb?(tag: tag)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(iv)
        addSubview(btn)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}







