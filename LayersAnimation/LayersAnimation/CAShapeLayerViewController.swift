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

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
