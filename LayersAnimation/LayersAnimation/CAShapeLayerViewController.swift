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
    
    @IBOutlet weak var fillRuleSegmentControl: UISegmentedControl!
    @IBOutlet weak var lineCapSegmentControl: UISegmentedControl!
    
    @IBOutlet weak var lineJoinSegmentControl: UISegmentedControl!
    
    @IBOutlet weak var fillSwitch: UISwitch!
    @IBOutlet weak var closePathSwitch: UISwitch!
    @IBOutlet weak var hueSlider: UISlider!
    enum FillRule: Int {
        case nonZero, evenOdd
    }
    
    enum LineCap: Int {
        case buff, round, square, cap
    }
    
    enum LineJoin: Int {
        case miter, round, bevel
    }

    var color = globalColor
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
        var selectedSegmentIndex: Int!
        if sender.isOn {
            selectedSegmentIndex = UISegmentedControlNoSegment
            shapeLayer.path = closePath.cgPath
        } else {
            switch shapeLayer.lineCap {
            case kCALineCapButt:
                selectedSegmentIndex = LineCap.buff.rawValue
            case kCALineCapRound:
                selectedSegmentIndex = LineCap.round.rawValue
            default:
                selectedSegmentIndex = LineCap.square.rawValue
            }
            shapeLayer.path = openPath.cgPath
        }
        
        lineCapSegmentControl.selectedSegmentIndex = selectedSegmentIndex
    }
    
 
    @IBAction func huiSliderValueChanged(_ sender: UISlider) {
        let hue = CGFloat(sender.value / 359.0)
        let color = UIColor(red: hue, green: 0.81, blue: 0.97, alpha: 1.0)
        shapeLayer.fillColor = fillSwitch.isOn ? color.cgColor : nil
        shapeLayer.strokeColor = color.cgColor
        self.color = color
    }

    @IBAction func fillSwitchValueChanged(_ sender: UISwitch) {
        var selectedSegmentIndex: Int
        if sender.isOn {
            shapeLayer.fillColor = color.cgColor
            if shapeLayer.fillRule == kCAFillRuleNonZero {
                selectedSegmentIndex = FillRule.nonZero.rawValue
            } else {
                selectedSegmentIndex = FillRule.evenOdd.rawValue
            }
        } else {
            selectedSegmentIndex = UISegmentedControlNoSegment
            shapeLayer.fillColor = nil
        }
        
        fillRuleSegmentControl.selectedSegmentIndex = selectedSegmentIndex
    }
    
    @IBAction func fillRuleSegmentControl(_ sender: UISegmentedControl) {
        fillSwitch.isOn = true
        shapeLayer.fillColor = color.cgColor
        
        var fillRule = kCAFillRuleNonZero
        
        if sender.selectedSegmentIndex != FillRule.nonZero.rawValue {
            fillRule = kCAFillRuleEvenOdd
        }
        shapeLayer.fillRule = fillRule
    }
    
    @IBAction func LineWidthSliderValueChanged(_ sender: UISlider) {
        shapeLayer.lineWidth = CGFloat(sender.value)
    }
    
    @IBAction func dashedSwitchValueChanged(_ sender: UISwitch) {
        if sender.isOn {
            shapeLayer.lineDashPattern = [50, 50]
            shapeLayer.lineDashPhase = 25.0
        } else {
            shapeLayer.lineDashPattern = nil
            shapeLayer.lineDashPhase = 0
        }
    }
    
    @IBAction func lineCropSegmentControl(_ sender: UISegmentedControl) {
    
        closePathSwitch.isOn = false
        shapeLayer.path = openPath.cgPath
        var lineCap = kCALineCapButt
        switch sender.selectedSegmentIndex {
        case LineCap.round.rawValue:
            lineCap = kCALineCapRound
        case LineCap.square.rawValue:
            lineCap = kCALineCapSquare
        default:
            break
        }
        shapeLayer.lineCap = lineCap
    }
    
    @IBAction func lineJoinSegmentControl(_ sender: UISegmentedControl) {
        var lineJoin = kCALineJoinMiter
        switch sender.selectedSegmentIndex {
        case LineJoin.round.rawValue:
            lineJoin = kCALineJoinRound
        case LineJoin.bevel.rawValue:
            lineJoin = kCALineJoinBevel
        default:
            break
        }
        shapeLayer.lineJoin = lineJoin
    }

}
