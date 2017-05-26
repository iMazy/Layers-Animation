//
//  AVPlayerLayerController.swift
//  LayersAnimation
//
//  Created by Mazy on 2017/5/26.
//  Copyright © 2017年 Mazy. All rights reserved.
//

import UIKit

class AVPlayerLayerController: UIViewController {
    
    
    @IBOutlet weak var viewForPlayerLayer: UIView!
    
    @IBOutlet weak var playButton: UIButton!
    
    @IBOutlet weak var rateSegmentControl: UISegmentedControl!
    
    
    @IBOutlet weak var loopSwitch: UISwitch!

    @IBOutlet weak var volumeSlider: UISlider!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    
    @IBAction func playButtonAction(_ sender: UIButton) {
    }


    @IBAction func rateSegmentControlValueChanged(_ sender: UISegmentedControl) {
    }


    @IBAction func loopSwitchValueChanged(_ sender: UISwitch) {
    }

    @IBAction func volumeSliderValueChanged(_ sender: UISlider) {
    }

}
