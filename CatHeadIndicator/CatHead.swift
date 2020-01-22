//
//  CatHead.swift
//  CatHeadIndicator
//
//  Created by Olga Lidman on 14.01.2020.
//  Copyright © 2020 Home. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
class CatHead: UIView {
    
//    let movingCircle = CAShapeLayer()
//    let startCircle = CAShapeLayer()
    var indicatorLayer: CAShapeLayer?
    var catHead: UIBezierPath!
    var circles = 0
    var timer: Timer!
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
//        indicatorLayer?.removeFromSuperlayer()
        
        for layer in self.layer.sublayers ?? [CALayer()] {
            layer.removeFromSuperlayer()
        }
        
        self.createPath()
        
        self.animateCatHead()

        }
    
    func animateCatHead() {
        
        self.timer = Timer.scheduledTimer(timeInterval: 0.125, target: self, selector: #selector(createCircle), userInfo: nil, repeats: true)
    }
    
    func createPath() {
        catHead = UIBezierPath()
        catHead.move(to: CGPoint(x: 2, y: 0))
        catHead.addLine(to: CGPoint(x: 22, y: 30))
        catHead.addLine(to: CGPoint(x: 62, y: 30))
        catHead.addLine(to: CGPoint(x: 82, y: 2))
        catHead.addLine(to: CGPoint(x: 82, y: 55))
        catHead.addArc(withCenter: CGPoint(x: 42, y: 55), radius: 40, startAngle: .pi*2, endAngle: .pi, clockwise: true)
        catHead.close()
//        catHead.stroke()
    }
    
    func startMoving(_ obj: CAShapeLayer,by path: CGPath) {
        let followPathAnimation = CAKeyframeAnimation(keyPath: "position")
        followPathAnimation.path = path
        followPathAnimation.calculationMode = .paced
        followPathAnimation.repeatCount = 9999
        followPathAnimation.duration = 3.5
        obj.add(followPathAnimation, forKey: nil)
    }
    
    @objc func createCircle() {
        self.circles += 1
        if self.circles > 28 {
            self.timer.invalidate()
            self.circles = 0
            return
        }
        let movingCircle = CAShapeLayer()
        movingCircle.backgroundColor = UIColor.black.cgColor
        movingCircle.bounds = CGRect(x: 0, y: 0, width: 9.0, height: 9.0)
        movingCircle.position = CGPoint(x: 2, y: 0)
        movingCircle.cornerRadius = 4.5
        self.layer.addSublayer(movingCircle)
        self.startMoving(movingCircle, by: self.catHead.cgPath)
    }

}
        
//        let width = self.bounds.size.width
//        let height = self.bounds.size.height

        
//        indicatorLayer = CAShapeLayer()
//        indicatorLayer?.path = catHead.cgPath
//        indicatorLayer?.strokeColor = UIColor.black.cgColor
//        indicatorLayer?.lineWidth = 7
//        indicatorLayer?.fillColor = nil
//        layer.addSublayer(indicatorLayer ?? CAShapeLayer())

//        let strokeEndAnimation = CABasicAnimation(keyPath: "strokeEnd")
//        strokeEndAnimation.fromValue = 0
//        strokeEndAnimation.toValue = 1
//        strokeEndAnimation.duration = 2
//        strokeEndAnimation.repeatCount = 10
//        indicatorLayer?.add(strokeEndAnimation, forKey: nil)
        
//        let strokeStartAnimation = CABasicAnimation(keyPath: "strokeStart")
//        strokeStartAnimation.fromValue = 0
//        strokeStartAnimation.toValue = 1
//        strokeStartAnimation.duration = 2
//        strokeStartAnimation.beginTime = 1
//        strokeEndAnimation.repeatCount = 10
//        indicatorLayer?.add(strokeStartAnimation, forKey: nil)

//        let animationGroup = CAAnimationGroup()
//        animationGroup.duration = 4
//        animationGroup.repeatCount = 10
//        animationGroup.animations = [strokeEndAnimation, strokeStartAnimation]
//        indicatorLayer?.add(animationGroup, forKey: nil)
    





