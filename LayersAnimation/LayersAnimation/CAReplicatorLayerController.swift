//
//  CAReplicatorLayerController.swift
//  LayersAnimation
//
//  Created by Mazy on 2017/5/30.
//  Copyright © 2017年 Mazy. All rights reserved.
//

import UIKit

class CAReplicatorLayerController: UIViewController {

    
    @IBOutlet weak var viewForLayer: UIView!
    
    @IBOutlet weak var layerSizeSlider: UISlider!
    @IBOutlet weak var layerSizeLabel: UILabel!
    
    @IBOutlet weak var instanceCountSlider: UISlider!
    @IBOutlet weak var instanceCountLabel: UILabel!
    
    @IBOutlet weak var instanceDelaySlider: UISlider!
    @IBOutlet weak var instanceDelayLabel: UILabel!
    
    @IBOutlet weak var fadeRedSwitch: UISwitch!
    @IBOutlet weak var fadeBlueSwitch: UISwitch!
    @IBOutlet weak var fadeGreenSwitch: UISwitch!
    @IBOutlet weak var fadeAlphaSwitch: UISwitch!
    
    
    let instanceLayer = CALayer()
    let replicatorLayer = CAReplicatorLayer()
    let fadeAnimation = CABasicAnimation(keyPath: "opacity")
    let lengthMultiplier: CGFloat = 3.0
    
    let pointLayer = CALayer()
    let staticPointLayer = CALayer()
    
    func setupLayerFadeAnimation() {
        fadeAnimation.fromValue = 1.0
        fadeAnimation.toValue = 0.0
        fadeAnimation.repeatCount = Float(Int.max)
    }
    
    func setupReplicatorLayer() {
        
        /// 设置尺寸
        replicatorLayer.frame = viewForLayer.bounds
        /// 设置放射数量
        let count = instanceCountSlider.value
        replicatorLayer.instanceCount = Int(count)
        replicatorLayer.preservesDepth = false
        /// 默认颜色
        replicatorLayer.instanceColor = UIColor.white.cgColor
        /// 颜色设置
        replicatorLayer.instanceRedOffset = offsetValueForSwitch(offsetSwitch: fadeRedSwitch)
        replicatorLayer.instanceBlueOffset = offsetValueForSwitch(offsetSwitch: fadeBlueSwitch)
        replicatorLayer.instanceGreenOffset = offsetValueForSwitch(offsetSwitch: fadeGreenSwitch)
        replicatorLayer.instanceAlphaOffset = offsetValueForSwitch(offsetSwitch: fadeAlphaSwitch)
        /// 旋转角度 360度
        let angle = Float(Double.pi*2.0)/count
        replicatorLayer.instanceTransform = CATransform3DMakeRotation(CGFloat(angle), 0.0, 0.0, 1.0)
    }
    
    func setupInstanceLayer() {
        let layerWidth = CGFloat(layerSizeSlider.value)
        let midX = viewForLayer.bounds.midX - layerWidth/2.0
        instanceLayer.frame = CGRect(x: midX, y: 0.0, width: layerWidth, height: layerWidth*lengthMultiplier)
        // 转动视图的颜色
        instanceLayer.backgroundColor = UIColor.white.cgColor
    }
    
    func setupPointLayer() {
        let layerWidth: CGFloat = 10.0
        let midX = viewForLayer.bounds.midX - layerWidth/2.0
        let maxY = viewForLayer.bounds.height/4
        pointLayer.frame = CGRect(x: midX, y: maxY, width: layerWidth, height: layerWidth)
        pointLayer.cornerRadius = layerWidth/2
        pointLayer.backgroundColor = UIColor.red.cgColor
    }
    
    func setupStaticPointLayer() {
        let layerWidth: CGFloat = 10.0
        let midX = viewForLayer.bounds.maxY - layerWidth/2.0
        let maxY = viewForLayer.bounds.height/4
        staticPointLayer.frame = CGRect(x: midX, y: maxY, width: layerWidth, height: layerWidth)
        staticPointLayer.cornerRadius = layerWidth/2
        staticPointLayer.backgroundColor = UIColor.red.cgColor
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupReplicatorLayer()
        viewForLayer.layer.addSublayer(replicatorLayer)
        
        setupInstanceLayer()
        replicatorLayer.addSublayer(instanceLayer)
        
        setupPointLayer()
        replicatorLayer.addSublayer(pointLayer)
        
        /// 设置ding
        setupStaticPointLayer()
        replicatorLayer.addSublayer(staticPointLayer)
        
        setupLayerFadeAnimation()
        
        sliderValueChanged(instanceDelaySlider)
        
    }
    

    
    
    @IBAction func sliderValueChanged(_ sender: UISlider) {
        switch sender {
        case layerSizeSlider:
            let value = CGFloat(sender.value)
            instanceLayer.bounds = CGRect(x: 0, y: 0, width: value, height: value*lengthMultiplier)
            layerSizeLabel.text = String(format: "%.0f x %.0f", value, value * lengthMultiplier)
        case instanceCountSlider:
            replicatorLayer.instanceCount = Int(instanceCountSlider.value)
            replicatorLayer.instanceAlphaOffset = offsetValueForSwitch(offsetSwitch: fadeAlphaSwitch)
            instanceCountLabel.text = String(format: "%.0f", sender.value)
            setupReplicatorLayer()
        case instanceDelaySlider:
            if sender.value > 0.0 {
                replicatorLayer.instanceDelay = CFTimeInterval(sender.value/Float(replicatorLayer.instanceCount))
                setLayerFadeAnimation()
                
            } else {
                replicatorLayer.instanceDelay = 0.0
                instanceLayer.opacity = 1.0
                instanceLayer.removeAllAnimations()
            }
            instanceDelayLabel.text = String(format: "%.0f", sender.value)
        default:break
        }
    }
    

    @IBAction func fadeColorSwitchValueChanged(_ sender: UISwitch) {
        switch sender {
        case fadeRedSwitch:
            replicatorLayer.instanceRedOffset = offsetValueForSwitch(offsetSwitch: sender)
        case fadeBlueSwitch:
            replicatorLayer.instanceBlueOffset = offsetValueForSwitch(offsetSwitch: sender)
        case fadeGreenSwitch:
            replicatorLayer.instanceGreenOffset = offsetValueForSwitch(offsetSwitch: sender)
        case fadeAlphaSwitch:
            replicatorLayer.instanceAlphaOffset = offsetValueForSwitch(offsetSwitch: sender)
        default:
            break
        }
    }
    
    /// 设置子 layer 动画
    func setLayerFadeAnimation() {
        instanceLayer.opacity = 0.0
        fadeAnimation.duration = CFTimeInterval(instanceDelaySlider.value)
        instanceLayer.add(fadeAnimation, forKey: "FadeAnimation")
        
        pointLayer.opacity = 0.0
        pointLayer.add(fadeAnimation, forKey: "FadeAnimation")
    }
    
    func offsetValueForSwitch(offsetSwitch: UISwitch) -> Float {
        if offsetSwitch == fadeAlphaSwitch {
            let count = Float(replicatorLayer.instanceCount)
            return offsetSwitch.isOn ? -1.0 / count : 0.0
        } else {
            return offsetSwitch.isOn ? 0.0 : -0.05
        }
    }
    

}
