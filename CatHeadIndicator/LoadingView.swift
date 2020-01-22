//
//  File.swift
//  CatHeadIndicator
//
//  Created by Olga Lidman on 13.01.2020.
//  Copyright © 2020 Home. All rights reserved.
//

import Foundation
import UIKit

enum DPDrawingIndicatorMode {
    case progressMode
    case defaultMode
}

private struct Constant {
    static let kFps = 1.0/60.0
}

@IBDesignable
class LoadingView: UIView {
    
    var indicatorLayer: CAShapeLayer?
    var degrees: CGFloat = 0
    var progressDegrees: CGFloat = 0
    var timer: Timer!
    var mode: DPDrawingIndicatorMode!
    var progress: CGFloat = 0 {
        didSet {
            self.progressDidChange()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.start()
    }
    
    public func start() {
        indicatorLayer?.removeFromSuperlayer()
        self.progressDegrees = 0
        self.mode = .defaultMode
        if self.timer != nil {
            self.timer.invalidate()
            self.timer = nil
        }
        _ = Timer.scheduledTimer(timeInterval: 3,
                                 target: self,
                                 selector: #selector(modeDidChange),
                                 userInfo: nil,
                                 repeats: false)
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)

        switch self.mode {
        case .defaultMode:
            self.degrees = 0
            self.timer = Timer.scheduledTimer(timeInterval: Constant.kFps,
                                                     target: self,
                                                     selector: #selector(self.drawLoader),
                                                     userInfo: nil,
                                                     repeats: true)
        case .progressMode:
            if self.progressDegrees >= 360 {
                self.progressDegrees = 0
            }
            self.timer = Timer.scheduledTimer(timeInterval: Constant.kFps,
                                                      target: self,
                                                      selector: #selector(self.drawLoaderWithProgress),
                                                      userInfo: nil,
                                                      repeats: true)
        default:
            return
        }
    }
    
    @objc func modeDidChange() {
        self.mode = .progressMode
        switch self.mode {
        case .defaultMode:
            if self.timer != nil {
                self.timer.invalidate()
                self.timer = nil
            }
            setNeedsDisplay()
            return
        case .progressMode:
            if self.timer != nil {
                self.timer.invalidate()
                self.timer = nil
            }
            progressChangeTimer()
            setNeedsDisplay()
        default:
            return
        }
    }
    
    func progressChangeTimer() {
        _ = Timer.scheduledTimer(timeInterval: 1,
                                 target: self,
                                 selector: #selector(self.progressChange),
                                 userInfo: nil,
                                 repeats: true)
    }
    
    @objc func progressChange() {
        if self.progressDegrees >= 360 { return }
        self.progress += 0.15
    }
    
    @objc func progressDidChange() {
        if self.timer == nil {
            setNeedsDisplay()
        }
    }
    
    
    @objc func drawLoaderWithProgress() {
        if (self.progressDegrees >= (self.progress * 360) && self.progress != 0) || self.progressDegrees >= 360 {
            if self.timer != nil {
                self.timer.invalidate()
                self.timer = nil
            }
        }
        self.progressDegrees += 2
        let loadCircle = UIBezierPath()
        loadCircle.addArc(withCenter: CGPoint(x: self.bounds.size.width/2,
                                              y: self.bounds.size.height/2),
                          radius: self.frame.size.width/2,
                          startAngle: .pi * 3/2,
                          endAngle: (.pi * 3/2) + (self.progressDegrees * .pi/180),
                          clockwise: true)
        
        loadCircle.stroke()
        
        indicatorLayer?.removeFromSuperlayer()
        
        indicatorLayer = CAShapeLayer()
        indicatorLayer?.path = loadCircle.cgPath
        indicatorLayer?.strokeColor = UIColor.black.cgColor
        indicatorLayer?.lineWidth = 9
        indicatorLayer?.fillColor = nil
        layer.addSublayer(indicatorLayer ?? CAShapeLayer())
    }
    
    @objc func drawLoader() {
        let loadCircle = UIBezierPath()
        loadCircle.addArc(withCenter: CGPoint(x: self.bounds.size.width/2,
                                              y: self.bounds.size.height/2),
                          radius: self.frame.size.width/2,
                          startAngle: (.pi * 5/3) + (self.degrees * .pi/180),
                          endAngle: (.pi * 3/2) + (self.degrees * .pi/180),
                          clockwise: true)
        
        loadCircle.stroke()
        
        indicatorLayer?.removeFromSuperlayer()
        
        indicatorLayer = CAShapeLayer()
        indicatorLayer?.path = loadCircle.cgPath
        indicatorLayer?.strokeColor = UIColor.black.cgColor
        indicatorLayer?.lineWidth = 9
        indicatorLayer?.fillColor = nil
        layer.addSublayer(indicatorLayer ?? CAShapeLayer())
        self.degrees += 2.0
    }
}

