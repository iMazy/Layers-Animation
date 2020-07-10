//
//  TiledLayer.swift
//  LayersAnimation
//
//  Created by Mazy on 2017/5/31.
//  Copyright © 2017年 Mazy. All rights reserved.
//

import UIKit

var adjustableFadeDuration: CFTimeInterval = 0.25

class TiledLayer: CATiledLayer {

    override class func fadeDuration() -> CFTimeInterval{
        return adjustableFadeDuration
    }
    
    class func setFadeDuration(duration: CFTimeInterval) {
        adjustableFadeDuration = duration
    }
}
