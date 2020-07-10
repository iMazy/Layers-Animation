//
//  ScrollingView.swift
//  LayersAnimation
//
//  Created by Mazy on 2017/5/24.
//  Copyright © 2017年 Mazy. All rights reserved.
//

import UIKit

class ScrollingView: UIView {

    /// 重写 layerClass 方法,获取 UIView 的子 layer 
    override class var layerClass: AnyClass {
        return CAScrollLayer.self
    }

}
