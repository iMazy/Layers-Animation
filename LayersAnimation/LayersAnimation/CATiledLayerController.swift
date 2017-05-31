//
//  CATiledLayerController.swift
//  LayersAnimation
//
//  Created by Mazy on 2017/5/31.
//  Copyright © 2017年 Mazy. All rights reserved.
//

import UIKit

class CATiledLayerController: UIViewController {

    @IBOutlet weak var viewForLayer: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var fadeDurationSlider: UISlider!
    @IBOutlet weak var fadeDurationSliderValueLabel: UILabel!
    @IBOutlet weak var tileSizeSlider: UISlider!
    @IBOutlet weak var tileSizeSliderValueLabel: UILabel!
    @IBOutlet weak var levelsOfDetailSlider: UISlider!
    @IBOutlet weak var levelsOfDetailSliderValueLabel: UILabel!
    @IBOutlet weak var detailBiasSlider: UISlider!
    @IBOutlet weak var detailBiasSliderValueLabel: UILabel!
    @IBOutlet weak var zoomScaleSlider: UISlider!
    @IBOutlet weak var zoomScaleSliderValueLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    
    @IBAction func fadeDurationSliderValueChanged(_ sender: UISlider) {
    }
    
    
    @IBAction func tileSizeSliderValueChanged(_ sender: UISlider) {
    }
    
    @IBAction func levelsOfDetailSliderValueChanged(_ sender: UISlider) {
    }
    
    @IBAction func detailBiasSliderValueChanged(_ sender: UISlider) {
    }
    
    @IBAction func zoomScaleSliderValueChanged(_ sender: UISlider) {
    }
    
}
