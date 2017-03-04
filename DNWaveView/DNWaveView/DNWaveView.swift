//
//  DNWaveView.swift
//  DNWaveView
//
//  Created by mainone on 2017/3/3.
//  Copyright © 2017年 mainone. All rights reserved.
//

import UIKit

class DNWaveView: UIView {
    
    fileprivate var offsetX: CGFloat?
    fileprivate var waveDisplayLink: CADisplayLink?
    fileprivate var waveShapeLayer: CAShapeLayer?
    
    /// 角速度
    public var angularSpeed: CGFloat? = 1.5
    // 水波速度
    public var waveSpeed: CGFloat? = 5.0
    // 水波时间
    public var waveTime: CGFloat? = 3
    // 水波颜色
    public var waveColor: UIColor? = UIColor.white
    
    // 添加波纹
    public class func add(to view: UIView, withFrame frame: CGRect) -> Any {
        let waveView = DNWaveView(frame: frame)
        waveView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(waveView)
        return waveView
    }

    // 开始波动
    @discardableResult public func wave() -> Bool {
        // 如果正在波动就不重复执行
        if waveShapeLayer?.path != nil {
            return false
        }
        
        // 创建波纹
        waveShapeLayer = CAShapeLayer()
        waveShapeLayer?.fillColor = waveColor?.cgColor
        layer.addSublayer(waveShapeLayer!)
        
        waveDisplayLink = CADisplayLink(target: self, selector: #selector(currentWave))
        waveDisplayLink?.add(to: RunLoop.main, forMode: .commonModes)
        // 一定时间后自动停止波动
        if Double(waveTime!) > 0.0 {
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(waveTime!), execute: {
                self.stop()
            })
        }
        return true
    }
    
    // 停止波动
    func stop() {
        UIView.animate(withDuration: 1.0, animations: {
            self.alpha = 0
        }) { (finished) in
            self.waveDisplayLink?.invalidate()
            self.waveDisplayLink = nil
            self.waveShapeLayer?.path = nil
            self.alpha = 1
        }
    }
    
    func currentWave() {
        self.offsetX = (self.offsetX ?? 0.0) - (self.waveSpeed ?? 0.0) * (self.superview?.frame.size.width)! / CGFloat(self.frame.size.width)
        let width: CGFloat = self.frame.width
        let height: CGFloat = self.frame.height
        let path: CGMutablePath = CGMutablePath()
        //设置移动到某点
        path.move(to: CGPoint(x: CGFloat(0), y: CGFloat(height / 2)), transform: .identity)
        var y: CGFloat = 0
        for x in 0...Int(width) {
            y = height * sin(0.01 * (self.angularSpeed! * CGFloat(x) + self.offsetX!))
            path.addLine(to: CGPoint(x: CGFloat(x), y: y), transform: .identity)
        }
        path.addLine(to: CGPoint(x: width, y: height), transform: .identity)
        path.addLine(to: CGPoint(x: CGFloat(0), y: height), transform: .identity)
        //闭合路径
        path.closeSubpath()
        self.waveShapeLayer?.path = path
    }
    
    
    
}
