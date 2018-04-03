//
//  FVRadarView.swift
//  radar  radar  RadarDemo
//
//  Created by james on 2017/12/15.
//  Copyright © 2017年 AiJiaSu Inc. All rights reserved.
//

import UIKit
protocol FVRadarChangeValueDelegate {
    func radarDidChangeValue(_ sender: Any)
}

class FVRadarView: UIView, CAAnimationDelegate {
    let animationDuration : CFTimeInterval = 2.5
    var animationGroup : CAAnimationGroup?
    var coreButton : UIButton!
    var timer : Timer?
    var delegate : FVRadarChangeValueDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createUI()
    }
    
    @objc func onTime() {
        let flayer = CALayer()
        flayer.cornerRadius = self.bounds
            .width/2
        flayer.frame = CGRect(x: 0, y: 0, width: self.bounds.width, height: self.bounds.width)
        flayer.backgroundColor = UIColor.gray.cgColor
        flayer.add(self.animationGroup!, forKey: "animation")
        self.layer.addSublayer(flayer)
        self.perform(#selector(removeLayer(_:)), with: flayer, afterDelay: animationDuration)
        
    }
   
    override func awakeFromNib() {
        super.awakeFromNib()
        createUI()
    }
    
    func createUI() {
        let scaleAnimation = CABasicAnimation(keyPath: "transform.scale.xy")
        scaleAnimation.fromValue = 0.0
        scaleAnimation.toValue = 1.0
        scaleAnimation.duration = animationDuration
        scaleAnimation.isRemovedOnCompletion = true
        
        let opacityAnimation = CAKeyframeAnimation(keyPath: "opacity")
        opacityAnimation.duration = animationDuration
        opacityAnimation.values = [1,0.5,0.3,0]
        opacityAnimation.keyTimes = [0,0.3,0.6,1]
        opacityAnimation.isRemovedOnCompletion = true
        
        self.animationGroup = CAAnimationGroup()
        self.animationGroup?.duration = animationDuration
        
        self.animationGroup?.isRemovedOnCompletion = false
        self.animationGroup?.fillMode = kCAFillModeForwards
        self.animationGroup?.delegate = self
        self.animationGroup?.animations = [scaleAnimation,opacityAnimation]
        coreButton = UIButton(frame: self.bounds)
        coreButton.setImage(UIImage(named: "buttonDisconnected"), for: .normal)
//        coreButton.setBackgroundImage(UIImage(named: "buttonDisconnected"), for: .normal)
//        coreButton.sizeToFit()
        coreButton.center = CGPoint(x: self.bounds.width / 2, y: self.bounds.height / 2)
       
        self.addSubview(coreButton)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    @objc func removeLayer(_ sender : CALayer) {
        sender.removeFromSuperlayer()
    }

    
    func animationStop() {
        if self.timer != nil {
            if (self.timer?.isValid)! {
                self.timer?.invalidate()
                self.timer = nil
                if self.layer.sublayers != nil {
                    for lay in self.layer.sublayers! {
                        lay.backgroundColor = UIColor.clear.cgColor
                    }
                }
            }
        }
        coreButton.setImage(UIImage(named: "buttonConnected"), for: .normal)
        coreButton.center = CGPoint(x: self.bounds.width / 2, y: self.bounds.height / 2)
    }
    
    func animationStart() {
        if timer == nil {
            onTime()
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(onTime), userInfo: nil, repeats: true)
            
            RunLoop.main.add(timer!, forMode: RunLoopMode.commonModes)

            self.perform(#selector(switchCoreButtonImage(_:)), with: UIImage(named: "IconConnecting"), afterDelay: 1)
        }
    }
    
    @objc func switchCoreButtonImage(_ image: UIImage?) {
        coreButton.setImage(image, for: .normal)
//        coreButton.setBackgroundImage(image, for: .normal)
//        coreButton.sizeToFit()
        coreButton.center = CGPoint(x: self.bounds.width / 2, y: self.bounds.height / 2)
    }
}
