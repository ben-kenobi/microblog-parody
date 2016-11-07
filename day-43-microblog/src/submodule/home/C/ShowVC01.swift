

//
//  ShowVC01.swift
//  day-43-microblog
//
//  Created by apple on 15/12/5.
//  Copyright © 2015年 yf. All rights reserved.
//

import UIKit

class ShowVC01: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor=UIColor.randColor()
        self.title="第\(self.navigationController?.childViewControllers.indexOf(self) ?? 0 )级VC"
        navigationItem.rightBarButtonItem=UIBarButtonItem(frame: CGRect(x: 0, y: 0, width: 50, height: 44), title: "Next",  tar: self, action: #selector(ShowVC01.rightClick))
        navigationItem.backBarButtonItem?.title="back"
    }
    
    func rightClick(){
        let str="qlkwek\(123)"
        navigationController?.showViewController(ShowVC01(), sender: nil)
    }
}
