

//
//  HomeTvCell.swift
//  day-43-microblog
//
//  Created by apple on 15/12/9.
//  Copyright © 2015年 yf. All rights reserved.
//

import UIKit
import SnapKit

class HomeTvCell: UITableViewCell {
    
    var botTopCon:Constraint?
    
    var mod:HomeMod?{
        didSet{
            
            mainv.mod=mod
            bot.mod=mod
            botTopCon?.uninstall()
            if mod?.retweeted_status != nil{
                retw.mod=mod?.retweeted_status
                bot.snp_updateConstraints(closure: { (make) -> Void in
                    botTopCon = make.top.equalTo(retw.snp_bottom).constraint
                })
                retw.hidden=false
                
            }else{
                retw.hidden=true
                bot.snp_updateConstraints(closure: { (make) -> Void in
                    botTopCon = make.top.equalTo(mainv.snp_bottom).constraint
                })
            }
        }
    }
    
    
    
    private lazy var mainv:HomeTvCellSubV0=HomeTvCellSubV0()
    private lazy var retw:ReTweetV=ReTweetV()
    private lazy var bot:HomeTvCellSubV1=HomeTvCellSubV1()
  
    
    func initUI(){
        contentView.addSubview(mainv)
        contentView.addSubview(retw)
         contentView.addSubview(bot)
       
        mainv.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(6)
            make.left.right.equalTo(0)
        }
        retw.snp_makeConstraints { (make) -> Void in
            make.left.right.equalTo(0)
            make.top.equalTo(mainv.snp_bottom)
        }
        bot.snp_makeConstraints { (make) -> Void in
            make.left.right.equalTo(0)
            make.height.equalTo(35)
            make.bottom.equalTo(0)
            botTopCon = make.top.equalTo(mainv.snp_bottom).constraint

        }
//        self.contentView.snp_makeConstraints { (make) -> Void in
//            make.top.left.right.equalTo(0)
//        }
        self.contentView.backgroundColor=iGlobalBG
    }
    
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initUI()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    


    
}
