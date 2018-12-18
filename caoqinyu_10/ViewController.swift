//
//  ViewController.swift
//  caoqinyu_10
//
//  Created by student on 2018/11/24.
//  Copyright © 2018年 2016110302. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    //定义两个视图用于切换
    var View1: UIView!
    var View2: UIView!
    var animator: UIDynamicAnimator!
    var gravity = UIGravityBehavior()//重力
    var collision = UICollisionBehavior()//碰撞
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        animation()
        transition()
        dynamicAnimation()
    }
    
    func animation() {
        let view = UIView(frame: CGRect(x: 300, y: 100, width: 100, height: 100))
        view.backgroundColor = UIColor.orange
        self.view.addSubview(view)
        
        UIView.animate(withDuration: 2, delay: 0, options: [.repeat, .autoreverse], animations: {
            //改变视图的大小位置
            view.frame = CGRect(x: 0, y: 20, width: 10, height: 10)
            view.backgroundColor = UIColor.yellow
            //改变视图的transform
            view.transform = view.transform.rotated(by: CGFloat.pi)
        }, completion: nil)
    }
    
    func transition() {
        //定义两个view
        View1 = UIView(frame: CGRect(x: 100, y: 300, width: 100, height: 100))
        View1.backgroundColor = UIColor.blue
        self.view.addSubview(View1)
        
        View2 = UIView(frame: CGRect(x: 100, y: 300, width: 100, height: 100))
        View2.backgroundColor = UIColor.purple
        self.view.addSubview(View2)
        let btn = UIButton(frame: CGRect(x: 0, y: 300, width: 100, height: 40))
        btn.setTitle("切换视图", for: .normal)
        btn.setTitleColor(UIColor.black, for: .normal)
        btn.addTarget(self, action: #selector(changeView), for: .touchUpInside)
        self.view.addSubview(btn)
        
        
    }
    
    func dynamicAnimation() {
        animator = UIDynamicAnimator(referenceView: self.view)
        //将重力和碰撞加入动画
        animator.addBehavior(gravity)
        animator.addBehavior(collision)
        collision.translatesReferenceBoundsIntoBoundary = true
        
        Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { (t) in
            let x = CGFloat(arc4random() % (UInt32(self.view.frame.width) - 50))
            let view = UIView(frame: CGRect(x: x, y: 20, width: 50, height: 50))
            view.backgroundColor = UIColor.yellow
            view.layer.borderWidth = 1
            view.layer.cornerRadius = 8
            self.view.addSubview(view)
            
            self.gravity.addItem(view)
            self.collision.addItem(view)
        }
    }
    
    //切换视图方法
    @objc func changeView() {
        UIView.transition(from: View2, to: View1, duration: 3, options: [.transitionCurlUp], completion: nil)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

