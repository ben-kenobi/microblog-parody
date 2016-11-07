

//
//  BlogPicV.swift
//  day-43-microblog
//
//  Created by apple on 15/12/11.
//  Copyright © 2015年 yf. All rights reserved.
//

import UIKit

class BlogPicV: UICollectionView,UICollectionViewDelegate,UICollectionViewDataSource {
    let itemw:CGFloat=(iScrW-60)/3
    let celliden="celliden"

    var pics:[BlogPics]?{
        didSet{
            updateSize(pics!.count)
            reloadData()
        }
    }
    func updateSize(count:Int){
        let col=count==4 ? 2: (count > 2 ? 3 : count)
        let row=col==0 ? 0: (count+col-1)/col
        let h = row==0 ? 0 : (self.itemw * CGFloat(row) + CGFloat(10 * (row+1)))
        let w = col==0 ? 0 : (self.itemw * CGFloat(col) + CGFloat(10 * (col+1)))
        self.contentSize=CGSizeMake(w, h)
        self.snp_updateConstraints { (make) -> Void in

            make.height.equalTo(h)
            make.width.equalTo(w)
        }
    }
    
    init(){
        let lo=UICollectionViewFlowLayout()
        lo.sectionInset=UIEdgeInsetsMake(10, 10, 10, 10)
        lo.minimumInteritemSpacing=10
        lo.minimumLineSpacing=10

        lo.itemSize=CGSizeMake(itemw, itemw)
        super.init(frame: CGRectMake(0, 0, 0, 0), collectionViewLayout: lo)
        delegate=self
        dataSource=self
        registerClass(BlogPicVCell.self, forCellWithReuseIdentifier: celliden)
        backgroundColor=UIColor.whiteColor()
        bounces=false
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        print("touch")
    }
    
}


extension BlogPicV:SDPhotoBrowserDelegate{
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        print(pics?.count ?? 0)
        return pics?.count ?? 0
    }
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell{
        let cell:BlogPicVCell = collectionView.dequeueReusableCellWithReuseIdentifier(celliden,forIndexPath: indexPath) as! BlogPicVCell
        
        cell.pic=pics![indexPath.row]
        return cell
    }
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let browser = SDPhotoBrowser()
        browser.imageCount=self.pics?.count ?? 0
        browser.sourceImagesContainerView=self
        browser.currentImageIndex=indexPath.item
        browser.delegate=self
        browser.show()

        
    }
    func photoBrowser(browser: SDPhotoBrowser!, highQualityImageURLForIndex index: Int) -> NSURL! {
        return iUrl(self.pics![index].thumbnail_pic?.stringByReplacingOccurrencesOfString("/thumbnail/", withString: "/bmiddle/"))

    }
    
    func photoBrowser(browser: SDPhotoBrowser!, placeholderImageForIndex index: Int) -> UIImage! {
        if let cell = self.cellForItemAtIndexPath(NSIndexPath(forItem: index, inSection: 0)) as?
            BlogPicVCell{
                return cell.img.image
        }
        
        return nil

    }
}


class BlogPicVCell:UICollectionViewCell{
    var pic:BlogPics?{
        didSet{
            if let url=pic?.thumbnail_pic {
                indicator.hidden = !url.hasSuffix("gif")
                img.sd_setImageWithURL(iUrl(url), placeholderImage: iimg("new_feature_2"))
            }
        }
    }
    private lazy var img:UIImageView={
        let img=UIImageView()
        img.contentMode=UIViewContentMode.ScaleAspectFill
        img.clipsToBounds=true
        return img
    }()
    
    private lazy var indicator:UIImageView=UIImageView(image: iimg("timeline_image_gif"))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(img)
        img.frame=self.bounds
        contentView.addSubview(indicator)
        indicator.snp_makeConstraints { (make) -> Void in
            make.right.bottom.equalTo(0)
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}


