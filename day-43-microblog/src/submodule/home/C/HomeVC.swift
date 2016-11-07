


//
//  HomeVC.swift
//  day-43-microblog
//
//  Created by apple on 15/12/5.
//  Copyright © 2015年 yf. All rights reserved.
//

import UIKit


class HomeVC: BaseVC   ,UITableViewDelegate,UITableViewDataSource{
    let celliden="hometvcelliden"
    
    private  lazy var footer:UIActivityIndicatorView={

        let indicator=UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.WhiteLarge)
        indicator.color=UIColor.orangeColor()
        indicator.h=63
        return indicator
    }()
    
    
    private lazy var tips:UILabel={
        let tip=UILabel(frame: CGRectMake(0, -50, iScrW, 50), color: UIColor.grayColor(), font: iFont(15), align: NSTextAlignment.Center, line: 1, bgColor: irandColor())
        tip.hidden=true
        return tip
        
    }()
    
    lazy var tv:UITableView={
        let tv=UITableView(frame: CGRect(x: 0, y: 0, width: self.view.w, height: self.view.h-iTopBarH-iTabBarH), style: UITableViewStyle.Plain)
        tv.delegate=self
        tv.dataSource=self
        tv.separatorStyle=UITableViewCellSeparatorStyle.None
        tv.registerClass(HomeTvCell.self, forCellReuseIdentifier:self.celliden)
        tv.rowHeight=UITableViewAutomaticDimension
        tv.estimatedRowHeight=200
        
        
//        tv.addFooterWithCallback { () -> Void in
//            self.tvm.loadHomeDatas (UserInfo.me?.access_token ,cb:{ (b) -> () in
//                tv.footerEndRefreshing()
//                if b{
//                    self.tv.reloadData()
//                }else{
//                    SVProgressHUD.showErrorWithStatus("fail to load datas")
//                }
//            })
//            
//        }
//        tv.addHeaderWithCallback { () -> Void in
//            self.tvm.loadHomeDatas (UserInfo.me?.access_token ,new:true,cb:{ (b) -> () in
//                tv.headerEndRefreshing()
//                if b{
//                    self.tv.reloadData()
//                }else{
//                    SVProgressHUD.showErrorWithStatus("fail to load datas")
//                }
//            })
//            
//        }
        
        

        return tv
    }()
    
     var tvm:HomeTVM=HomeTVM()
    
    lazy var ref:RefreshC={
        let ref=RefreshC()
        ref.addTarget(self, action: #selector(HomeVC.loadDatas), forControlEvents: UIControlEvents.ValueChanged)
//        ref.attributedTitle=NSAttributedString(string: "refreshing", attributes: [NSFontAttributeName:iFont(22),NSForegroundColorAttributeName:UIColor.orangeColor()])
//        ref.tintColor=UIColor.orangeColor()
        return ref
    }()
    
    
    override func loginLoad() {
        super.loginLoad()
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(img: UIImage(named: "navigationbar_friendsearch"), hlimg:UIImage(named: "navigationbar_friendsearch_highlighted"), tar: self, action: #selector(HomeVC.leftClick))
        self.navigationItem.rightBarButtonItem=UIBarButtonItem(img: UIImage(named: "navigationbar_pop"), hlimg: UIImage(named: "navigationbar_pop_highlighted"), tar: self, action: #selector(HomeVC.rightClick))
        view.addSubview(tv)
        
//        tv.headerBeginRefreshing()
        tv.tableFooterView=footer
        tv.addSubview(ref)
        ref.beginRefreshing()
        
    }
    
    
    
  
}


extension HomeVC{
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return tvm.mod.count ?? 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        
        let cell:HomeTvCell=tableView.dequeueReusableCellWithIdentifier(celliden,forIndexPath: indexPath) as! HomeTvCell
        cell.mod=tvm.mod[indexPath.row]
        
        return cell
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        if tvm.mod.count > 0 && indexPath.row==tvm.mod.count-1 && !footer.isAnimating() {
            footer.startAnimating()
            loadDatas()
        }
        
    }
    
    func loadDatas(){
        
        if !tips.hidden && !self.footer.isAnimating(){
             self.ref.endRefreshing()
            return
        }
        
        dispatch_after(dispatch_time(0, Int64(1e9)), dispatch_get_main_queue(), { () -> Void in
            self.tvm.loadHomeDatas(UserInfo.me?.access_token,new:!self.footer.isAnimating(), cb: { (b,count) -> () in
                
                if b{
                    self.tv.reloadData()
                    if !self.footer.isAnimating(){
                        self.showTips(count)
                    }
                    
                }else{
                    iPop.showMsg("fail to load datas")
                }
                if !self.footer.isAnimating(){
                    self.ref.endRefreshing()
                }else{
                    self.footer.stopAnimating()
                }
                
            })
        })
        
    }
    
    
    private func showTips(count:Int){
        if !tips.hidden{
            return
        }
        if self.tips.superview==nil{
            self.view.addSubview(self.tips)
        }
        tips.text="加载\(count)条心数据"
        tips.hidden=false
        UIView.animateWithDuration(0.5, animations: { () -> Void in
            self.tips.transform=CGAffineTransformMakeTranslation(0, self.tips.h)
            }) { (_) -> Void in
                UIView.animateWithDuration(0.25, delay: 1, options: [], animations: { () -> Void in
                    self.tips.transform=CGAffineTransformIdentity
                    }, completion: { (_) -> Void in
                        self.tips.hidden=true
                })
                
        }
    }
    
}


extension HomeVC{
    override func unloginLoad() {
        super.unloginLoad()
    }
    
    func leftClick(){
        navigationController?.showViewController(ShowVC01(), sender: nil)
    }
    func rightClick(){
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        
    }
    
}
