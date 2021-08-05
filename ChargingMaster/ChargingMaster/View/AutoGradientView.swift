//
//  AutoGradientView.swift
//  ChargingMaster
//
//  Created by 张哲炜 on 2021/8/5.
//

import UIKit


class AutoGradientView: UIView {
    
    var caGradientLayer = CAGradientLayer()
    var progress: CGFloat = 0.0
    var startColors:[Any]?
    var endColors:[Any]?
    var timer: Timer?
    let colors = [
            UIColor.init(red: 162/255, green: 94/255, blue: 255/255, alpha: 1).cgColor,
            UIColor.init(red: 108/255, green: 153/255, blue: 255/255, alpha: 1).cgColor,
            UIColor.init(red: 105/255, green: 201/255, blue: 255/255, alpha: 1).cgColor,
            UIColor.init(red: 102/255, green: 235/255, blue: 221/255, alpha: 1).cgColor,
            UIColor.init(red: 103/255, green: 249/255, blue: 145/255, alpha: 1).cgColor,
            UIColor.init(red: 228/255, green: 250/255, blue: 139/255, alpha: 1).cgColor,
            UIColor.init(red: 255/255, green: 198/255, blue: 88/255, alpha: 1).cgColor,
            UIColor.init(red: 255/255, green: 120/255, blue: 102/255, alpha: 1).cgColor,
            UIColor.init(red: 162/255, green: 94/255, blue: 255/255, alpha: 1).cgColor
        ]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initGradientLayer()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initGradientLayer()
    }
    
    func initGradientLayer() {
        caGradientLayer = CAGradientLayer()
        caGradientLayer.frame = CGRect(x: 0,
                                       y: 0,
                                       width: UIScreen.main.bounds.size.width,
                                       height: UIScreen.main.bounds.size.height)
        caGradientLayer.startPoint = CGPoint(x: 0, y: 0)
        caGradientLayer.endPoint = CGPoint(x: 1, y: 0)
        let colors2 = [colors[0],colors[1]]
        caGradientLayer.colors = colors2
        startColors = colors2
        
        self.layer.addSublayer(caGradientLayer)
        self.gradientAnimation()
    }
    
    @objc func gradientAnimation() {
        var colorArray = caGradientLayer.colors
        
        if endColors != nil {
            startColors = endColors
        }
        colorArray?.removeFirst()
        colorArray?.append(colors[Int(progress) + 2])
        endColors = colorArray
        let animation = CABasicAnimation(keyPath: "colors")
        animation.fromValue = startColors
        animation.toValue = endColors
        animation.duration = 1
        animation.fillMode = CAMediaTimingFillMode.forwards
        animation.isRemovedOnCompletion = false
        animation.delegate = self
        caGradientLayer.add(animation, forKey: "animateGradient")
    }
    
}

extension AutoGradientView: CAAnimationDelegate {
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        caGradientLayer.colors = endColors
        gradientAnimation()
        progress += 1.0
        if Int(progress + 2) >= colors.count {
            progress = 0
        }
    }
    
}
