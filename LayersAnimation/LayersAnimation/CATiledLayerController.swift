//
//  CATiledLayerController.swift
//  LayersAnimation
//
//  Created by Mazy on 2017/5/31.
//  Copyright © 2017年 Mazy. All rights reserved.
//

import UIKit

class CATiledLayerController: UIViewController {

    @IBOutlet weak var viewForTiledLayer: TilingView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var fadeDurationSlider: UISlider!
    @IBOutlet weak var fadeDurationSliderValueLabel: UILabel!
    @IBOutlet weak var tileSizeSlider: UISlider!
    @IBOutlet weak var tileSizeSliderValueLabel: UILabel!
    @IBOutlet weak var levelsOfDetailSlider: UISlider!
    @IBOutlet weak var levelsOfDetailSliderValueLabel: UILabel!
    @IBOutlet weak var detailBiasSlider: UISlider!
    @IBOutlet weak var detailBiasSliderValueLabel: UILabel!
    @IBOutlet weak var zoomScaleSlider: UISlider!
    @IBOutlet weak var zoomScaleSliderValueLabel: UILabel!
    
    var tiledLayer: TiledLayer {
        return viewForTiledLayer.layer as! TiledLayer
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.delegate = self
        scrollView.contentSize = scrollView.frame.size
        
        updateZoomScaleSliderValueLabel()
        updateTiledSizeSliderValueLabel()
        updateDetailBiasSliderValueLabel()
        updateFadeDurationSliderValueLabel()
        updateLevelsOfDetailSliderValueLabel()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "大图", style: .plain, target: self, action: #selector(toTilingView))

    }
    
    @objc func toTilingView() {
        
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "tilingImageView")
        navigationController?.show(vc, sender: nil)
    }

    deinit {
        TiledLayer.setFadeDuration(duration: CFTimeInterval(0.25))
    }
    
    @IBAction func fadeDurationSliderValueChanged(_ sender: UISlider) {
        TiledLayer.setFadeDuration(duration: CFTimeInterval(sender.value))
        updateFadeDurationSliderValueLabel()
        tiledLayer.contents = nil
        tiledLayer.setNeedsDisplay(tiledLayer.bounds)
    }
    
    
    @IBAction func tileSizeSliderValueChanged(_ sender: UISlider) {
        let value = Int(sender.value)
        tiledLayer.tileSize = CGSize(width: value, height: value)
        updateTiledSizeSliderValueLabel()
    }
    
    
    @IBAction func levelsOfDetailSliderValueChanged(_ sender: UISlider) {
        tiledLayer.levelsOfDetail = Int(sender.value)
        updateLevelsOfDetailSliderValueLabel()
    }
    
    @IBAction func detailBiasSliderValueChanged(_ sender: UISlider) {
        tiledLayer.levelsOfDetailBias = Int(sender.value)
        updateDetailBiasSliderValueLabel()
    }
    
    @IBAction func zoomScaleSliderValueChanged(_ sender: UISlider) {
        scrollView.zoomScale = CGFloat(sender.value)
        updateZoomScaleSliderValueLabel()
    }
    
    func updateFadeDurationSliderValueLabel() {
        fadeDurationSliderValueLabel.text = String(format: "%.2f", adjustableFadeDuration)
    }
    
    func updateTiledSizeSliderValueLabel() {
        tileSizeSliderValueLabel.text = "\(Int(tiledLayer.tileSize.width))"
    }
    
    func updateLevelsOfDetailSliderValueLabel() {
        levelsOfDetailSliderValueLabel.text = "\(tiledLayer.levelsOfDetail)"
    }
    
    func updateDetailBiasSliderValueLabel() {
        detailBiasSliderValueLabel.text = "\(tiledLayer.levelsOfDetailBias)"
    }
    
    func updateZoomScaleSliderValueLabel() {
        zoomScaleSliderValueLabel.text = "\(CGFloat(scrollView.zoomScale))"
    }
    
}

extension CATiledLayerController: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return viewForTiledLayer
    }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        zoomScaleSlider.setValue(Float(scrollView.zoomScale), animated: true)
        updateZoomScaleSliderValueLabel()
    }
}
