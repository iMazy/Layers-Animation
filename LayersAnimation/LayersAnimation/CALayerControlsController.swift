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
        case displayContents, geometryFlipped, hidden
    }
    
    enum Slider: Int {
        case opacity, cornerRadius, borderWidth, shadowOpacity, shadowRadius
    }
    
    enum MagnificationFilter: Int {
        case linear, nearest, trilinear
    }
    
    var contentsGravityValues = [kCAGravityCenter, kCAGravityTop, kCAGravityBottom, kCAGravityLeft, kCAGravityRight, kCAGravityTopLeft, kCAGravityTopRight, kCAGravityBottomLeft, kCAGravityBottomRight, kCAGravityResize, kCAGravityResizeAspect, kCAGravityResizeAspectFill] as [String]
    
    var contentsGravityPickerVisible = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        contentsGravityPicker.delegate = self
        contentsGravityPicker.dataSource = self
        
        updateSliderValueLabels()
    }
    
    @IBAction func switchChanged(_ sender: UISwitch) {
        // 获取点击的 switch 的索引
        guard let theIndex = switches.index(of: sender),
             // 获取当前的 switch 的位置
             let theSwitch = Switch(rawValue: theIndex) else { return }
        switch theSwitch {
        case .displayContents:
            layerViewController.layer.contents = sender.isOn ? layerViewController.iconImage : nil
        case .geometryFlipped:
            layerViewController.layer.isGeometryFlipped = sender.isOn
        case .hidden:
            layerViewController.layer.isHidden = sender.isOn
        }
    }
    
    @IBAction func sliderValueChanged(_ sender: UISlider) {
        // 获取索引
        guard let theIndex = sliders.index(of: sender),
             // 获取当前 slider 的位置
             let theSlider = Slider(rawValue: theIndex) else { return }
        switch theSlider {
        case .opacity:
            layerViewController.layer.opacity = sender.value
        case .cornerRadius:
            layerViewController.layer.cornerRadius = CGFloat(sender.value)
        case .borderWidth:
            layerViewController.layer.borderWidth = CGFloat(sender.value)
        case .shadowOpacity:
            layerViewController.layer.shadowOpacity = sender.value
        case .shadowRadius:
            layerViewController.layer.shadowRadius = CGFloat(sender.value)
        }
        
        // 修改 label 的值
        updateSliderValueLabel(theSlider)
    }
    
    func updateSliderValueLabels() {
        for slider in Slider.opacity.rawValue...Slider.shadowOpacity.rawValue {
            updateSliderValueLabel(Slider(rawValue: slider)!)
        }
    }
    
    func updateSliderValueLabel(_ sliderEnum: Slider) {
        let index = sliderEnum.rawValue
        let label = sliderValueLabels[index]
        let slider = sliders[index]
        
        switch sliderEnum {
            case .opacity, .shadowOpacity:
                label.text = String(format: "%.2f", slider.value)
            case .borderWidth, .cornerRadius, .shadowRadius:
                label.text = "\(Int(slider.value))"
        }
    }
    
    @IBAction func borderColorSliderValueChanged(_ sender: UISlider) {
        let colorAndLabelText = colorAndLabelForSliders(borderColorSliders)
        layerViewController.layer.borderColor = colorAndLabelText.color
        borderColorSlidersValueLabel.text = colorAndLabelText.labelText
    }
    
    @IBAction func backgroundColorSliderValueChanged(_ sender: UISlider) {
        let colorAndLabelText = colorAndLabelForSliders(backgroundColorSliders)
        layerViewController.layer.backgroundColor = colorAndLabelText.color
        backgroundColorSlidersValueLabel.text = colorAndLabelText.labelText
    }
    
    @IBAction func shadowOffsetSliderValueChanged(_ sender: UISlider) {
        var width: CGFloat = 0
        var height: CGFloat = 0
        for slider in shadowOffsetSliders {
            switch slider.tag {
            case 101:
                width = CGFloat(slider.value)
            case 102:
                height = CGFloat(slider.value)
            default:
                break
            }
        }
        layerViewController.layer.shadowOffset = CGSize(width: width, height: height)
        shadowOffsetSlidersValueLabel.text = "Width: \(Int(width)), Height: \(Int(height))"
    }
    
    
    
    @IBAction func shadowColorSliderValueChanged(_ sender: UISlider) {
        let colorAndLabelText = colorAndLabelForSliders(shadowColorSliders)
        layerViewController.layer.shadowColor = colorAndLabelText.color
        shadowColorSlidersValueLabel.text = colorAndLabelText.labelText
    }
    
    @IBAction func magnificationSegmentedControlValueChanged(_ sender: UISegmentedControl) {
        let filter = MagnificationFilter(rawValue: sender.selectedSegmentIndex)!
        var filterValue = ""
        switch filter {
        case .linear:
            filterValue = kCAFilterLinear
        case .nearest:
            filterValue = kCAFilterNearest
        case .trilinear:
            filterValue = kCAFilterTrilinear
        }
        layerViewController.layer.magnificationFilter = filterValue
    }
    
    
    /// 通过数组设置颜色
    ///
    /// - Parameter sliders: 颜色数据, slider 控制
    /// - Returns: 返回颜色 和 颜色字符串
    func colorAndLabelForSliders(_ sliders: [UISlider]) -> (color: CGColor, labelText: String) {
        
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        for slider in sliders {
            switch slider.tag {
            case 101:
                red = CGFloat(slider.value)
            case 102:
                green = CGFloat(slider.value)
            case 103:
                blue = CGFloat(slider.value)
            default: break
            }
        }
        let color = UIColor(red: red/255.0, green: green/255.0, blue: blue/255.0, alpha: 1.0).cgColor
        let labelText = "RGB: \(Int(red)), \(Int(green)), \(Int(blue))"
        return (color, labelText)
    }
}


// MARK: - tableViewDelegate/dataSource
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
}

extension CALayerControlsController {
    /// 显示属性选择
    func showContentsGravityPicker() {
        contentsGravityPickerVisible = true
        relayoutTableViewCells()
        let index = contentsGravityValues.index(of: layerViewController.layer.contentsGravity)
        contentsGravityPicker.selectRow(index!, inComponent: 0, animated: false)
        contentsGravityPicker.isHidden = false
        contentsGravityPicker.alpha = 0
        
        UIView.animate(withDuration: 0.25) { [unowned self] in
            self.contentsGravityPicker.alpha = 1.0
        }
    }
    
    /// 隐藏属性选择
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
    
    
    /// 重新布局 cells
    func relayoutTableViewCells() {
        tableView.beginUpdates()
        tableView.endUpdates()
    }
}

// MARK: - UIPickerViewDelegate,UIPickerViewDataSource
extension CALayerControlsController: UIPickerViewDelegate,UIPickerViewDataSource {
    @available(iOS 2.0, *)
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return contentsGravityValues.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return contentsGravityValues[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        layerViewController.layer.contentsGravity = contentsGravityValues[row]
        contentsGravityPickerValueLabel.text = layerViewController.layer.contentsGravity
    }
}
