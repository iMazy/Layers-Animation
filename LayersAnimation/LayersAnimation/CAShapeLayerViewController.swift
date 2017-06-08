//
//  CAShapeLayerViewController.swift
//  LayersAnimation
//
//  Created by Mazy on 2017/6/8.
//  Copyright © 2017年 Mazy. All rights reserved.
//

import UIKit

class CAShapeLayerViewController: UIViewController {
    
    
    @IBOutlet weak var viewForSharpLayer: UIView!
    @IBOutlet weak var lineWidthSlider: UISlider!
    
    enum FillRule: Int {
        case nonZero, evenOdd
    }
    
    enum LineCap: Int {
        case buff, round, square, cap
    }
    
    enum LineJoin: Int {
        case miter, round, bevel
    }

    let shapeLayer = CAShapeLayer()
    
    let openPath = UIBezierPath()
    
    let closePath = UIBezierPath()
    
    func setupOpenPath() {
        openPath.move(to: CGPoint(x: 30, y: 196))
        openPath.addCurve(to: CGPoint(x: 112.0, y: 12.5), controlPoint1: CGPoint(x: 110.56, y: 13.79), controlPoint2: CGPoint(x: 112.07, y: 13.01))
        openPath.addCurve(to: CGPoint(x: 194, y: 196), controlPoint1: CGPoint(x: 111.0, y: 11.81), controlPoint2: CGPoint(x: 194, y: 196))
        openPath.addLine(to: CGPoint(x: 30.0, y: 85.68))
        openPath.addLine(to: CGPoint(x: 194.0, y: 48.91))
        openPath.addLine(to: CGPoint(x: 30, y: 196))
    }
    
    func setupClosePath() {
        closePath.cgPath = openPath.cgPath.mutableCopy()!
        closePath.close()
    }
    
    func setupShapeLayer() {
        shapeLayer.path = openPath.cgPath
        shapeLayer.fillColor = nil
        shapeLayer.fillRule = kCAFillRuleNonZero
        shapeLayer.lineCap = kCALineCapButt
        shapeLayer.lineDashPattern = nil
        shapeLayer.lineDashPhase = 0.0
        shapeLayer.lineJoin = kCALineJoinMiter
        shapeLayer.lineWidth = CGFloat(lineWidthSlider.value)
        shapeLayer.miterLimit = 4.0
        shapeLayer.strokeColor = globalColor.cgColor
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupOpenPath()
        setupClosePath()
        setupShapeLayer()
        viewForSharpLayer.layer.addSublayer(shapeLayer)
    }
    
    @IBAction func closePathSwitchValueChanged(_ sender: UISwitch) {
    }
    
    @IBAction func colorSwitchValueChanged(_ sender: Any) {
    }

    @IBAction func fillSwitchValueChanged(_ sender: UISwitch) {
    }
    
    @IBAction func fillRuleSegmentControl(_ sender: UISegmentedControl) {
    }
    
    @IBAction func LineWidthSliderValueChanged(_ sender: UISlider) {
    }
    
    @IBAction func dashedSwitchValueChanged(_ sender: UISwitch) {
    }
    
    @IBAction func lineCropSegmentControl(_ sender: UISegmentedControl) {
    }
    
    @IBAction func lineJoinSegmentControl(_ sender: UISegmentedControl) {
    }

}
