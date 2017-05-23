//
//  CALayerControlsController.swift
//  LayersAnimation
//
//  Created by  Mazy on 2017/5/23.
//  Copyright © 2017年 Mazy. All rights reserved.
//

import UIKit

class CALayerControlsController: UITableViewController {
    
    @IBOutlet weak var contentsGravityPickerValueLabel: UILabel!
    @IBOutlet weak var contentsGravityPicker: UIPickerView!
    @IBOutlet var switches: [UISwitch]!
    @IBOutlet var sliderValueLabels: [UILabel]!
    @IBOutlet var sliders: [UISlider]!
    @IBOutlet weak var borderColorSlidersValueLabel: UILabel!
    @IBOutlet var borderColorSliders: [UISlider]!
    @IBOutlet weak var backgroundColorSlidersValueLabel: UILabel!
    @IBOutlet var backgroundColorSliders: [UISlider]!
    @IBOutlet weak var shadowOffsetSlidersValueLabel: UILabel!
    @IBOutlet var shadowOffsetSliders: [UISlider]!
    @IBOutlet weak var shadowColorSlidersValueLabel: UILabel!
    @IBOutlet var shadowColorSliders: [UISlider]!
    @IBOutlet weak var magnificationFilterSegmentedControl: UISegmentedControl!
    
    weak var layerViewController: CALayerViewController!
    
    enum row: Int {
        case contentsGravity, contentsGravityPicker, displayContents, geometryFlipped, hidden, opacity, cornerRadius, borderWidth, borderColor, backgroundColor, shadowOpacity, shadowOffset, shadowRadius, shadowColor, magnificationFilter
    }
    
    enum Switch: Int {
        case opacity, cornerRadius, borderWidth, shadowOpacity, shadowRadius
    }
    
    enum ColorSlider: Int {
        case red, green, blue
    }
    
    enum MagnificationFilter: Int {
        case linear, nearest, trilinear
    }
    
    var contentsGravityValues = [kCAGravityCenter, kCAGravityTop, kCAGravityBottom, kCAGravityLeft, kCAGravityRight, kCAGravityTopLeft, kCAGravityTopRight, kCAGravityBottomLeft, kCAGravityBottomRight, kCAGravityResize, kCAGravityResizeAspect, kCAGravityResizeAspectFill] as NSArray
    
    var contentsGravityPickerVisible = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

       
    }
}
