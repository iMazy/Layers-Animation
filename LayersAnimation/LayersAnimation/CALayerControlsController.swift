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
    
    enum Row: Int {
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

        contentsGravityPicker.delegate = self
        contentsGravityPicker.dataSource = self
    }
}

extension CALayerControlsController {
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let row = Row(rawValue: indexPath.row)
        if row == .contentsGravityPicker {
            return contentsGravityPickerVisible ? 162.0 : 0.0
        }
        return 44.0
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        defer {
            tableView.deselectRow(at: indexPath, animated: true)
        }
        
        let row = Row(rawValue: indexPath.row)!
        switch row {
        case .contentsGravity where !contentsGravityPickerVisible:
            showContentsGravityPicker()
        default:
            hideContentsGravityPicker()
        }
        
    }
    
    func showContentsGravityPicker() {
        contentsGravityPickerVisible = true
        relayoutTableViewCells()
        let index = contentsGravityValues.index(of: layerViewController.layer.contentsGravity)
        contentsGravityPicker.selectRow(index, inComponent: 0, animated: false)
        contentsGravityPicker.isHidden = false
        contentsGravityPicker.alpha = 0
        
        UIView.animate(withDuration: 0.25) { [unowned self] in
            self.contentsGravityPicker.alpha = 1.0
        }
    }
    
    func hideContentsGravityPicker() {
        if contentsGravityPickerVisible {
            tableView.isUserInteractionEnabled = false
            contentsGravityPickerVisible = false
            relayoutTableViewCells()
            
            UIView.animate(withDuration: 0.25, animations: { [unowned self] in
                self.contentsGravityPicker.alpha = 0
            }, completion: { [unowned self] (_) in
                self.contentsGravityPicker.isHidden = true
                self.tableView.isUserInteractionEnabled = true
            })
        }
    }
    
    func relayoutTableViewCells() {
        tableView.beginUpdates()
        tableView.endUpdates()
    }
}

extension CALayerControlsController: UIPickerViewDelegate,UIPickerViewDataSource {
    @available(iOS 2.0, *)
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return contentsGravityValues.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return contentsGravityValues[row] as? String
    }
}
