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
    
    
    
    enum Font: Int {
        case helvatica, noteorthyLight
    }
    
    enum AlignmentMode: Int {
        case left, center, justified, right
    }
    
    enum TruncationMode: Int {
        case start, middle, end
    }
    
    let textLayer = CATextLayer()
    
    var fontSize: CGFloat = 24.0
    let baseFontSize: CGFloat = 24.0
    
    var helveticaFont :AnyObject?
    var noteworkthyLigthFont: AnyObject?
    
    var previouslySelectedTrunctionMode = TruncationMode.end
    
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
        textLayer.alignmentMode = kCAAlignmentLeft
        textLayer.truncationMode = kCATruncationEnd
        textLayer.contentsScale = UIScreen.main.scale
    }
    
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
        textLayer.alignmentMode = kCAAlignmentLeft
        
        if sender.isOn {
            if let truncationMode = TruncationMode(rawValue: truncationModeSegmentedControl.selectedSegmentIndex) {
                previouslySelectedTrunctionMode = truncationMode
            }
            truncationModeSegmentedControl.selectedSegmentIndex = UISegmentedControlNoSegment
            textLayer.isWrapped = true
        } else {
            textLayer.isWrapped = false
            truncationModeSegmentedControl.selectedSegmentIndex = previouslySelectedTrunctionMode.rawValue
        }
    }
    
    @IBAction func alignmentModeSegmentedControlChanged(_ sender: UISegmentedControl) {
        wrapTextSwitch.isOn = true
        textLayer.isWrapped = true
        truncationModeSegmentedControl.selectedSegmentIndex = UISegmentedControlNoSegment
        textLayer.truncationMode = kCATruncationNone
        
        switch sender.selectedSegmentIndex {
        case AlignmentMode.left.rawValue:
            textLayer.alignmentMode = kCAAlignmentLeft
        case AlignmentMode.center.rawValue:
            textLayer.alignmentMode = kCAAlignmentCenter
        case AlignmentMode.justified.rawValue:
            textLayer.alignmentMode = kCAAlignmentJustified
        case AlignmentMode.right.rawValue:
            textLayer.alignmentMode = kCAAlignmentRight
        default:
            textLayer.alignmentMode = kCAAlignmentLeft
            break
        }
    }
    
    @IBAction func truncationModeSegmentedControlChanged(_ sender: UISegmentedControl) {
        wrapTextSwitch.isOn = false
        textLayer.isWrapped = false
        alignmentModeSegmentedControl.selectedSegmentIndex = UISegmentedControlNoSegment
        textLayer.alignmentMode = kCAAlignmentLeft
        
        switch sender.selectedSegmentIndex {
        case TruncationMode.start.rawValue:
            textLayer.truncationMode = kCATruncationStart
        case TruncationMode.middle.rawValue:
            textLayer.truncationMode = kCATruncationMiddle
        case TruncationMode.end.rawValue:
            textLayer.truncationMode = kCATruncationEnd
        default:
            textLayer.truncationMode = kCATruncationNone
        }
    }
   
}
