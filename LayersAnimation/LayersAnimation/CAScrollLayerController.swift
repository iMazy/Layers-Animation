//
//  CAScrollLayerController.swift
//  LayersAnimation
//
//  Created by Mazy on 2017/5/24.
//  Copyright © 2017年 Mazy. All rights reserved.
//

import UIKit

class CAScrollLayerController: UIViewController {

    @IBOutlet weak var scrollLayerView: ScrollingView!
    @IBOutlet weak var horizontalScrollingSwitch: UISwitch!
    @IBOutlet weak var verticalScrollingSwitch: UISwitch!
    
    @IBOutlet weak var autoBackToHomeSwitch: UISwitch!
    
    var scrollingViewLayer: CAScrollLayer {
        return scrollLayerView.layer as! CAScrollLayer
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollingViewLayer.scrollMode = kCAScrollBoth
    }

    
    @IBAction func panGesture (_ sender: UIPanGestureRecognizer) {
        
        var newPoint = scrollLayerView.bounds.origin
        newPoint.x -= sender.translation(in: scrollLayerView).x
        newPoint.y -= sender.translation(in: scrollLayerView).y
        sender.setTranslation(CGPoint.zero, in: scrollLayerView)
        
        scrollingViewLayer.scroll(to: newPoint)
        
        if autoBackToHomeSwitch.isOn {
            if sender.state == .ended {
                UIView.animate(withDuration: 0.3, animations: { [unowned self] in
                    self.scrollingViewLayer.scroll(to: CGPoint.zero)
                })
            }
        }
        
    }
    
    
    @IBAction func scrollingSwitchChanged(_ sender: UISwitch) {
        switch (horizontalScrollingSwitch.isOn, verticalScrollingSwitch.isOn) {
        case (true, true):
            scrollingViewLayer.scrollMode = kCAScrollBoth
        case (true, false):
            scrollingViewLayer.scrollMode = kCAScrollHorizontally
        case (false, true):
            scrollingViewLayer.scrollMode = kCAScrollVertically
        default:
            scrollingViewLayer.scrollMode = kCAScrollNone
        }
    }

}
