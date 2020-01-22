//
//  CheckMark.swift
//  CatHeadIndicator
//
//  Created by Olga Lidman on 21.01.2020.
//  Copyright © 2020 Home. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
class CheckMark: UIView {
    
    var indicatorLayer: CAShapeLayer?
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        indicatorLayer?.removeFromSuperlayer()
        
        drawCheckMark()
    }
    
    @objc func drawCheckMark() {
        let width = self.bounds.size.width
        let height = self.bounds.size.height
        let mark = UIBezierPath()
        mark.move(to: CGPoint(x: width*2/10, y: height/2))
        mark.addLine(to: CGPoint(x: width*2/5, y: height*7/10))
        mark.addLine(to: CGPoint(x: width*8/10, y: height*2/7))
        
        indicatorLayer = CAShapeLayer()
        indicatorLayer?.path = mark.cgPath
        indicatorLayer?.strokeColor = UIColor.black.cgColor
        indicatorLayer?.lineWidth = 9
        indicatorLayer?.fillColor = nil
        layer.addSublayer(indicatorLayer ?? CAShapeLayer())
        
        let strokeStartAnimation = CABasicAnimation(keyPath: "strokeEnd")
        strokeStartAnimation.fromValue = 0
        strokeStartAnimation.toValue = 1
        strokeStartAnimation.duration = 1
        indicatorLayer?.add(strokeStartAnimation, forKey: nil)
    }
}
