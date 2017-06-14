//
//  CATransformLayerController.swift
//  LayersAnimation
//
//  Created by Mazy on 2017/6/14.
//  Copyright © 2017年 Mazy. All rights reserved.
//

import UIKit

func degreesToRadians(_ degress: Double) -> CGFloat {
    return CGFloat(degress * M_PI / 180.0)
}

func radiansToDegrees(_ radians: Double) -> CGFloat {
    return CGFloat(radians / M_PI * 180.0)
}

class CATransformLayerController: UIViewController {

    @IBOutlet weak var boxTappedLabel: UILabel!
    @IBOutlet weak var viewForTransformLayer: UIView!
    @IBOutlet var colorAlphaSwitches: [UISwitch]!
    
    
    enum Color: Int {
        case red, orange, yellow, green, bule, purple
    }
    
    let sideLength = CGFloat(160.0)
    let reducedAlpha = CGFloat(0.8)
    
    var transformLayer: CATransformLayer!
    let swipeMeTextLayer = CATextLayer()
    var redColor = UIColor.red
    var orangeColor = UIColor.orange
    var yellowColor = UIColor.yellow
    var greenColor = UIColor.green
    var blueColor = UIColor.blue
    var purpleColor = UIColor.purple
    
    var trackBall: TrackBall?
    
    func sortOutletCollections() {
        colorAlphaSwitches.sortUIViewsInPlaceByTag()
    }
    
    func setupSwipeMeTextLayer() {
        swipeMeTextLayer.frame = CGRect(x: 0.0, y: sideLength/4.0, width: sideLength, height: sideLength/2.0)
        swipeMeTextLayer.string = "Swipe Me"
        swipeMeTextLayer.alignmentMode = kCAAlignmentCenter
        swipeMeTextLayer.foregroundColor = UIColor.white.cgColor
        let fontName = "Noteworthy-Light" as CFString
        let fontRef = CTFontCreateWithName(fontName, 24.0, nil)
        swipeMeTextLayer.font = fontRef
        swipeMeTextLayer.contentsScale = UIScreen.main.scale
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        sortOutletCollections()
        setupSwipeMeTextLayer()
        
        buildCube()
        
    }
    
    
    @IBAction func colorAlphaValueChanged(_ sender: UISwitch) {
        
    }
    
    
    func buildCube() {
        transformLayer = CATransformLayer()
        
        var layer = sideLayerWithColor(redColor)
        layer.addSublayer(swipeMeTextLayer)
        transformLayer.addSublayer(layer)
        
        layer = sideLayerWithColor(orangeColor)
        var transform = CATransform3DMakeTranslation(sideLength / 2, 0.0, sideLength / -2)
        transform = CATransform3DRotate(transform, degreesToRadians(90), 0, 1, 0)
        layer.transform = transform
        transformLayer.addSublayer(layer)
        
        layer = sideLayerWithColor(yellowColor)
        layer.transform = CATransform3DMakeTranslation(0, 0, -sideLength)
        transformLayer.addSublayer(layer)
        
        layer = sideLayerWithColor(greenColor)
        transform = CATransform3DMakeTranslation(sideLength / -2, 0, sideLength / -2)
        transform = CATransform3DRotate(transform, degreesToRadians(90), 0, 1, 0)
        layer.transform = transform
        transformLayer.addSublayer(layer)
        
        layer = sideLayerWithColor(blueColor)
        transform = CATransform3DMakeTranslation(0, sideLength / -2, sideLength / -2)
        transform = CATransform3DRotate(transform, degreesToRadians(90), 1, 0, 0)
        layer.transform = transform
        transformLayer.addSublayer(layer)
        
        layer = sideLayerWithColor(purpleColor)
        transform = CATransform3DMakeTranslation(0, sideLength / 2, sideLength / -2)
        transform = CATransform3DRotate(transform, degreesToRadians(90), 1, 0, 0)
        layer.transform = transform
        transformLayer.addSublayer(layer)
        
        transformLayer.anchorPointZ = sideLength / -2
        viewForTransformLayer.layer.addSublayer(transformLayer)
    }
    
    func sideLayerWithColor(_ color: UIColor) -> CALayer {
        let layer = CALayer()
        layer.frame = CGRect(origin: CGPoint.zero, size: CGSize(width: sideLength, height: sideLength))
        layer.position = CGPoint(x: viewForTransformLayer.bounds.midX, y: viewForTransformLayer.bounds.midY)
        layer.backgroundColor = color.cgColor
        return layer
    }
    
    func colorForColor(_ color: UIColor, withAlpha newAlpha: CGFloat) -> UIColor {
        var color = color
        var red = CGFloat()
        var green = red, blue = red, alpha = red
        
        if color.getRed(&red, green: &green, blue: &blue, alpha: &alpha) {
            color = UIColor(red: red, green: green, blue: blue, alpha: newAlpha)
        }
        return color
    }

}

extension Array where Element: UIView {
    
    /**
     Sorts an array of UIViews or subclasses by tag. For example, this is useful when working with `IBOutletCollection`s, whose order of elements can be changed when manipulating the view objects in Interface Builder. Just tag your views in Interface Builder and then call this method on your `IBOutletCollection`s in `viewDidLoad()`.
     - author: Scott Gardner
     - seealso:
     * [Source on GitHub](http://bit.ly/SortUIViewsInPlaceByTag)
     */
    mutating func sortUIViewsInPlaceByTag() {
        sort { (left: Element, right: Element) in
            left.tag < right.tag
        }
    }
    
}
