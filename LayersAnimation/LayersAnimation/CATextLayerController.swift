//
//  CATextLayerController.swift
//  LayersAnimation
//
//  Created by Mazy on 2017/5/25.
//  Copyright © 2017年 Mazy. All rights reserved.
//

import UIKit

class CATextLayerController: UIViewController {

    
    @IBOutlet weak var viewForTextLayer: UIView!
    @IBOutlet weak var fontSizeSliderValueLabel: UILabel!
    @IBOutlet weak var fontSizeSlider: UISlider!
    @IBOutlet weak var wrapTextSwitch: UISwitch!
    @IBOutlet weak var alignmentModeSegmentedControl: UISegmentedControl!
    @IBOutlet weak var truncationModeSegmentedControl: UISegmentedControl!
    
    
    /// 字体
    enum Font: Int {
        case helvatica, noteorthyLight
    }
    
    /// 对其方式
    enum AlignmentMode: Int {
        case left, center, justified, right
    }
    
    /// 显示方式
    enum TruncationMode: Int {
        case start, middle, end
    }
    
    /// 文本 layer
    let textLayer = CATextLayer()
    /// 字体大小
    var fontSize: CGFloat = 24.0
    /// 基本字体大小
    let baseFontSize: CGFloat = 24.0
    /// 字体
    var helveticaFont :AnyObject?
    var noteworkthyLigthFont: AnyObject?
    
    var previouslySelectedTrunctionMode = TruncationMode.end
    
    /// 设置 textLayer
    func setupTextLayer() {
        textLayer.frame = viewForTextLayer.bounds
        var string = ""
        for _ in 1...10 {
            string += "幸运，从来都是强者的谦辞。每个幸运者的背后，都有着与幸运无关的故事!\n"
        }
        textLayer.string = string
        textLayer.font = helveticaFont
        textLayer.foregroundColor = UIColor.darkGray.cgColor
        textLayer.isWrapped = true
        textLayer.alignmentMode = CATextLayerAlignmentMode.left
        textLayer.truncationMode = CATextLayerTruncationMode.end
        textLayer.contentsScale = UIScreen.main.scale
    }
    
    /// 创建字体
    func createFont() {
        var fontName: CFString = "Noteworthy-Light" as CFString
        noteworkthyLigthFont = CTFontCreateWithName(fontName, baseFontSize, nil)
        
        fontName = "Helvetica" as CFString
        helveticaFont = CTFontCreateWithName(fontName, baseFontSize, nil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        createFont()
        setupTextLayer()
        viewForTextLayer.layer.addSublayer(textLayer)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        textLayer.frame = viewForTextLayer.bounds
        textLayer.fontSize = fontSize
    }
    
    @IBAction func fontSegmentControlChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case Font.helvatica.rawValue:
            textLayer.font = helveticaFont
        case Font.noteorthyLight.rawValue:
            textLayer.font = noteworkthyLigthFont
        default: break
        }
    }

    @IBAction func fontSizeSliderValueChanged(_ sender: UISlider) {
        fontSizeSliderValueLabel.text = "\(Int(sender.value * 100.0))%"
        fontSize = baseFontSize * CGFloat(sender.value)
    }
    
    @IBAction func wrapTextSwitchChanged(_ sender: UISwitch) {
        alignmentModeSegmentedControl.selectedSegmentIndex = AlignmentMode.left.rawValue
        textLayer.alignmentMode = CATextLayerAlignmentMode.left
        
        if sender.isOn {
            if let truncationMode = TruncationMode(rawValue: truncationModeSegmentedControl.selectedSegmentIndex) {
                previouslySelectedTrunctionMode = truncationMode
            }
            truncationModeSegmentedControl.selectedSegmentIndex = UISegmentedControl.noSegment
            textLayer.isWrapped = true
        } else {
            textLayer.isWrapped = false
            truncationModeSegmentedControl.selectedSegmentIndex = previouslySelectedTrunctionMode.rawValue
        }
    }
    
    @IBAction func alignmentModeSegmentedControlChanged(_ sender: UISegmentedControl) {
        wrapTextSwitch.isOn = true
        textLayer.isWrapped = true
        truncationModeSegmentedControl.selectedSegmentIndex = UISegmentedControl.noSegment
        textLayer.truncationMode = CATextLayerTruncationMode.none
        
        switch sender.selectedSegmentIndex {
        case AlignmentMode.left.rawValue:
            textLayer.alignmentMode = CATextLayerAlignmentMode.left
        case AlignmentMode.center.rawValue:
            textLayer.alignmentMode = CATextLayerAlignmentMode.center
        case AlignmentMode.justified.rawValue:
            textLayer.alignmentMode = CATextLayerAlignmentMode.justified
        case AlignmentMode.right.rawValue:
            textLayer.alignmentMode = CATextLayerAlignmentMode.right
        default:
            textLayer.alignmentMode = CATextLayerAlignmentMode.left
            break
        }
    }
    
    @IBAction func truncationModeSegmentedControlChanged(_ sender: UISegmentedControl) {
        wrapTextSwitch.isOn = false
        textLayer.isWrapped = false
        alignmentModeSegmentedControl.selectedSegmentIndex = UISegmentedControl.noSegment
        textLayer.alignmentMode = CATextLayerAlignmentMode.left
        
        switch sender.selectedSegmentIndex {
        case TruncationMode.start.rawValue:
            textLayer.truncationMode = CATextLayerTruncationMode.start
        case TruncationMode.middle.rawValue:
            textLayer.truncationMode = CATextLayerTruncationMode.middle
        case TruncationMode.end.rawValue:
            textLayer.truncationMode = CATextLayerTruncationMode.end
        default:
            textLayer.truncationMode = CATextLayerTruncationMode.none
        }
    }
   
}
