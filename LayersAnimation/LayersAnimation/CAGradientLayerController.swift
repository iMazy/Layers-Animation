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
    
    @IBOutlet var colorSwitchs: [UISwitch]!
    
    @IBOutlet var locationSliders: [UISlider]!
    
    @IBOutlet var locationSliderValueLabels: [UILabel]!
    
    var colors = [AnyObject]()
    var locations: [Float] = [0, 1/6.0, 1/3.0, 1/2, 2/3.0, 5/6.0, 1.0]
    
    
    
    let gradientLayer = CAGradientLayer()
    
    func setupGradientLayer() {
        setupColors()
        gradientLayer.frame = viewForGradientLayer.bounds
        gradientLayer.colors = colors
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
        gradientLayer.locations = locations as [NSNumber]?
    }
    
    func setupSildersLocation() {
        let sliders = locationSliders
        
        for (index, slider) in (sliders?.enumerated())! {
            slider.value = locations[index]
        }
    }
    
    func updateLocationSliderValueLabels() {
        for (index, label) in locationSliderValueLabels.enumerated() {
            let colorSwitch = colorSwitchs[index]
            
            if colorSwitch.isOn {
                let slider = locationSliders[index]
                label.text = String(format: "%.2f", slider.value)
                label.isEnabled = true
            } else {
                label.isEnabled = false
            }
        }
    }
    
    func setupColors() {
        colors = [cgColor(colors: (209,0,0)),
                  cgColor(colors: (205,102,24)),
                  cgColor(colors: (255,218,33)),
                  cgColor(colors: (51,221,0)),
                  cgColor(colors: (17,51,204)),
                  cgColor(colors: (34,0,102)),
                  cgColor(colors: (51,0,68))]
    }
    
    func cgColor(colors: (CGFloat,CGFloat,CGFloat)) -> AnyObject {
        return UIColor(red: colors.0/255.0, green: colors.1/255.0, blue: colors.2/255.0, alpha: 1.0).cgColor as AnyObject
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupGradientLayer()
        viewForGradientLayer.layer.addSublayer(gradientLayer)
        
        setupSildersLocation()
        updateLocationSliderValueLabels()
    }
    
    @IBAction func startPointSliderValueChanged(_ sender: UISlider) {
        gradientLayer.startPoint = CGPoint(x: Double(sender.value), y: 0.0)
        startLabel.text = String(format: "(%.1f, 0.0)", sender.value)
    }
    
    @IBAction func endPointSliderValueChanged(_ sender: UISlider) {
        gradientLayer.endPoint = CGPoint(x: Double(sender.value), y: 1.0)
        endLabel.text = String(format: "(%.1f, 1.0)", sender.value)
    }

    @IBAction func colorsSwitchValueChanged(_ sender: UISwitch) {
        var gradientLayerColors = [AnyObject]()
        var locations = [NSNumber]()
        
        for (index, colorSwitch) in colorSwitchs.enumerated() {
            let slider = locationSliders[index]
            
            if colorSwitch.isOn {
                gradientLayerColors.append(colors[index])
                locations.append(NSNumber(value: slider.value))
                slider.isEnabled = true
            } else {
                slider.isEnabled = false
            }
        }
        
        if gradientLayerColors.count == 1 {
            gradientLayerColors.append(gradientLayerColors[0])
        }
        gradientLayer.colors = gradientLayerColors
        gradientLayer.locations = locations.count > 1 ? locations : nil
        updateLocationSliderValueLabels()
    }
    
    @IBAction func colorSliderValueChanged(_ sender: UISlider) {
        
        var gradientLocations = [NSNumber]()
        
        for (index, slider) in locationSliders.enumerated() {
            
            let colorSwitch = colorSwitchs[index]
            
            if colorSwitch.isOn {
                gradientLocations.append(NSNumber(value: slider.value))
            }
        }
        
        gradientLayer.locations = gradientLocations
        updateLocationSliderValueLabels()
    }

}
