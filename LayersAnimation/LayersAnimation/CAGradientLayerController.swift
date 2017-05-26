//
//  CAGradientLayerController.swift
//  LayersAnimation
//
//  Created by Mazy on 2017/5/26.
//  Copyright © 2017年 Mazy. All rights reserved.
//

import UIKit

class CAGradientLayerController: UIViewController {
    
    @IBOutlet weak var viewForGradientLayer: UIView!
    @IBOutlet weak var startLabel: UILabel!
    @IBOutlet weak var endLabel: UILabel!
    @IBOutlet weak var redLabel: UILabel!
    @IBOutlet weak var orangeLabel: UILabel!
    @IBOutlet weak var yellowLabel: UILabel!
    @IBOutlet weak var greenLabel: UILabel!
    @IBOutlet weak var blueLabel: UILabel!
    @IBOutlet weak var indigoLabel: UILabel!
    @IBOutlet weak var violetLabel: UILabel!
    
    var colors = [AnyObject]()
    let locations: [Float] = [0, 1/6.0, 1/3.0, 1/2, 2/3.0, 5/6.0, 1.0]
    
    
    let gradientLayer = CAGradientLayer()
    
    func setupGradientLayer() {
        gradientLayer.frame = viewForGradientLayer.bounds
        gradientLayer.colors = [UIColor.red.cgColor,UIColor.green.cgColor]

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupGradientLayer()
        viewForGradientLayer.layer.addSublayer(gradientLayer)
    }

    @IBAction func startAndEedSliderValueChanged(_ sender: UISlider) {
        switch sender.tag {
        case Direction.start.rawValue:
            gradientLayer.startPoint = CGPoint(x: Double(sender.value), y: 0.0)
        default:
            gradientLayer.endPoint = CGPoint(x: Double(sender.value), y: 1.0)
        }
    }
    
    @IBAction func colorsSwitchValueChanged(_ sender: UISwitch) {
    }
    
    @IBAction func colorSliderValueChanged(_ sender: UISlider) {
    }

}
