//
//  ViewController.swift
//  CatHeadIndicator
//
//  Created by Olga Lidman on 04/04/2019.
//  Copyright © 2019 Home. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

@IBDesignable
class View : UIView {
    
    let movingCircle = CAShapeLayer()
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        let startCircle = CAShapeLayer()
        startCircle.backgroundColor = UIColor.black.cgColor
        startCircle.bounds = CGRect(x: 0, y: 0, width: 7, height: 7)
        startCircle.position = CGPoint(x: 2, y: 0)
        startCircle.cornerRadius = 3.5
        self.layer.addSublayer(startCircle)
        
        movingCircle.backgroundColor = UIColor.black.cgColor
        movingCircle.bounds = CGRect(x: 0, y: 0, width: 7, height: 7)
        movingCircle.position = CGPoint(x: 2, y: 0)
        movingCircle.cornerRadius = 3.5
        self.layer.addSublayer(movingCircle)
        
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        let catHead = UIBezierPath()
        catHead.move(to: CGPoint(x: 2, y: 0))
//        catHead.addArc(withCenter: CGPoint(x: 4, y: 0), radius: 2, startAngle: .pi, endAngle: .pi*2, clockwise: true)
        catHead.addLine(to: CGPoint(x: 22, y: 30))
        catHead.addLine(to: CGPoint(x: 62, y: 30))
        catHead.addLine(to: CGPoint(x: 80, y: 2))
        catHead.addArc(withCenter: CGPoint(x: 82, y: 2), radius: 1, startAngle: .pi, endAngle: .pi*2, clockwise: true)
        catHead.addLine(to: CGPoint(x: 82, y: 55))
        catHead.addArc(withCenter: CGPoint(x: 42, y: 55), radius: 40, startAngle: .pi*2, endAngle: .pi, clockwise: true)
        catHead.close()
        catHead.stroke()

        let indicatorLayer = CAShapeLayer()
        indicatorLayer.path = catHead.cgPath
        indicatorLayer.strokeColor = UIColor.black.cgColor
        indicatorLayer.lineWidth = 7
        indicatorLayer.fillColor = nil
        layer.addSublayer(indicatorLayer)

        let strokeStartAnimation = CABasicAnimation(keyPath: "strokeStart")
        strokeStartAnimation.fromValue = 0
        strokeStartAnimation.toValue = 1
        strokeStartAnimation.duration = 2
        strokeStartAnimation.beginTime = 2

        let strokeEndAnimation = CABasicAnimation(keyPath: "strokeEnd")
        strokeEndAnimation.fromValue = 0
        strokeEndAnimation.toValue = 1
        strokeEndAnimation.duration = 2

        let animationGroup = CAAnimationGroup()
        animationGroup.duration = 4
        animationGroup.repeatCount = 10000000272564224
        animationGroup.animations = [strokeEndAnimation, strokeStartAnimation]
        indicatorLayer.add(animationGroup, forKey: nil)
        
        let followPathAnimation = CAKeyframeAnimation(keyPath: "position")
        followPathAnimation.path = catHead.cgPath
        followPathAnimation.calculationMode = CAAnimationCalculationMode.paced
        followPathAnimation.repeatCount = 10000000272564224
        followPathAnimation.duration = 2
        movingCircle.add(followPathAnimation, forKey: nil)
    }
}

