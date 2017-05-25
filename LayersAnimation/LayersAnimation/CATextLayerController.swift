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
    
    
    
    enum Font {
        case helvatica, noteorthyLight
    }
    
    enum AlignmentMode: Int {
        case left, center, justified, right
    }
    
    enum TruncationMode: Int {
        case start, middle, end
    }
    
    let textLayer = CATextLayer()
    
    let fontSize: CGFloat = 24.0
    let baseFontSize: CGFloat = 24.0
    
    var helveticaFont :AnyObject?
    var noteworkthyLigthFont: AnyObject?
    
    var previouslySelectedTrunctionMode = TruncationMode.end
    
    func setupTextLayer() {
        textLayer.frame = viewForTextLayer.bounds
        let string = "为什么原本亲密的关系会变淡？或许有人会说因为大家都忙'没时间联系'少见面…我在想~为什么没人敢坦诚的承认，是因为社会资源'地位'见识差距变大了。渐渐的你的苦闷他无法理解，他的彷徨在你而言是变相炫耀。两个人无话可说，只能叙旧，直到过去被反复咀嚼，淡而无味，又碍于情面怕被指责势利，还要勉强维持点赞的情分！许多曾经只能被拿来怀念，许多因恩面结的缘最后成了负担…我越来越觉得朋友是需要交换观点的，而不仅仅是交换感情的！能一直同路的人太少'所以珍惜每段路上的每个朋友，就算到了分岔口'温柔道别'谨记彼此的好！"
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
    

   
}
