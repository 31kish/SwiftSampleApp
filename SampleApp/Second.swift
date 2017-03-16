//
//  Second.swift
//  SampleApp
//
//  Created by 桑原慶之 on 2017/03/17.
//  Copyright © 2017年 KeishiKuwabara. All rights reserved.
//
// 参考
// http://qiita.com/ShinokiRyosei/items/06fb30983236d6342b28

import UIKit

class Second: UIViewController, UITextViewDelegate {

    // UINavigationControllerとself.presentで戻り方（閉じ方）が違うため
    // それを判定するためのフラグ
    var isPush: Bool?

    var textView: UITextView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        configureObserver()
    }

    func configureObserver() {
        let notification = NotificationCenter.default
        notification.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        notification.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        resetObserver()
    }
    
    func resetObserver() {
        let notification = NotificationCenter.default
        notification.removeObserver(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.green
        
        self.textView = UITextView()
        self.textView.frame = CGRect(x: 80, y: 60, width: 200, height: 400)
        self.textView.inputAccessoryView = createAccessoryView()
        self.textView.delegate = self
        self.view.addSubview(textView)
        
        let button: UIButton! = UIButton()
        button.frame = CGRect(x: 80, y: 30, width:120, height: 30)
        button.setTitle("Tap", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.setTitleColor(UIColor.gray, for: .highlighted)
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 1
        button.addTarget(self, action: #selector(onButtonClick(sender:)), for: .touchUpInside)
        self.view.addSubview(button)
    }

    func onButtonClick(sender: UIButton) {
        if self.isPush! {
            // UINavigationControllerは画面を管理しているので前の画面を知っている
            // なのでpopで戻れる
            self.navigationController!.popViewController(animated: true)
        }
        else {
            // self.presentはモーダルダイアログのようなイメージ
            // 前の画面を知らないので、自分自身を閉じる（dismiss）
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    func createAccessoryView() -> UIView {
        let v: UIView = UIView()
        v.frame = CGRect(x: 0, y: 0, width: self.view.bounds.size.width, height: 40)
        v.backgroundColor = UIColor.darkGray
        
        let c: UIButton = UIButton()
        c.backgroundColor = UIColor.lightGray
        c.frame = CGRect(x: self.view.bounds.size.width - 80, y: 5, width: 80, height: 30)
        c.setTitle("閉じる", for: .normal)
        c.setTitleColor(UIColor.blue, for: .normal)
        c.setTitleColor(UIColor.gray, for: .highlighted)
        c.addTarget(self, action: #selector(closeKeyboard(sender:)), for: .touchUpInside)

        v.addSubview(c)
        return v
    }
    
    func closeKeyboard(sender: UIButton) {
        self.textView.resignFirstResponder()
    }
    
    // キーボードが現れた時に、画面全体をずらす
    func keyboardWillShow(notification: Notification?) {
        
        let rect = (notification?.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue
        let duration: TimeInterval? = notification?.userInfo?[UIKeyboardAnimationDurationUserInfoKey] as? Double
        UIView.animate(withDuration: duration!, animations: { () in
            let transform = CGAffineTransform(translationX: 0, y: -(rect?.size.height)!)
            self.view.transform = transform
            
        })
    }

    // キーボードが消えたときに、画面を戻す
    func keyboardWillHide(notification: Notification?) {
        
        let duration: TimeInterval? = notification?.userInfo?[UIKeyboardAnimationCurveUserInfoKey] as? Double
        UIView.animate(withDuration: duration!, animations: { () in
            
            self.view.transform = CGAffineTransform.identity
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
