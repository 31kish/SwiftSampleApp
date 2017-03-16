//
//  ViewController.swift
//  SampleApp
//
//  Created by 桑原慶之 on 2017/03/17.
//  Copyright © 2017年 KeishiKuwabara. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.white
        
        let label: UILabel! = UILabel()
        label.frame = CGRect(x: 80, y: 80, width: 160, height: 40)
        label.text = "Hellow Sample App"
        label.backgroundColor = UIColor.red
        self.view.addSubview(label)

        let button: UIButton! = UIButton()
        button.frame = CGRect(x: 80, y: 160, width:120, height: 30)
        button.setTitle("Tap", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.setTitleColor(UIColor.gray, for: .highlighted)
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 1
        button.addTarget(self, action: #selector(onButtonClick(sender:)), for: .touchUpInside)
        self.view.addSubview(button)
        
        let modalButton: UIButton! = UIButton()
        modalButton.frame = CGRect(x: 80, y: 240, width:120, height: 30)
        modalButton.setTitle("Tap", for: .normal)
        modalButton.setTitleColor(UIColor.black, for: .normal)
        modalButton.setTitleColor(UIColor.green, for: .highlighted)
        modalButton.layer.cornerRadius = 10
        modalButton.layer.borderWidth = 1
        modalButton.addTarget(self, action: #selector(onButtonClick(sender:)), for: .touchUpInside)
        self.view.addSubview(modalButton)
        
        button.tag = 1
        modalButton.tag = 2
    }

    func onButtonClick(sender: UIButton) {
        NSLog("onButtonClick")

        let second: Second = Second()
        
        if sender.tag == 1 {
            // UINavigationControllerを使った遷移
            self.navigationController?.pushViewController(second, animated: true)

            // 画面遷移には関係ない
            second.isPush = true
        }
        else {
            // UINavigationControllerじゃない遷移
            self.present(second, animated: true, completion: nil)

            // 画面遷移には関係ない
            second.isPush = false
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

