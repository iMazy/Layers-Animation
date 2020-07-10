//
//  AVPlayerLayerController.swift
//  LayersAnimation
//
//  Created by Mazy on 2017/5/26.
//  Copyright © 2017年 Mazy. All rights reserved.
//

import UIKit
import AVFoundation

class AVPlayerLayerController: UIViewController {
    

    @IBOutlet weak var viewForPlayerLayer: UIView!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var rateSegmentControl: UISegmentedControl!
    @IBOutlet weak var loopSwitch: UISwitch!
    @IBOutlet weak var volumeSlider: UISlider!
    
    enum Rate: Int {
        case slowForward, normal, fasrForward
    }
    
    let playerLayer = AVPlayerLayer()
    var player: AVPlayer {
        return playerLayer.player!
    }
    
    var rateBeforePause: Float?
    var shouldLoop = true
    var isPlaying = false
    
    // 设置播放 layer
    func setupPlayerLayer() {
        playerLayer.frame = viewForPlayerLayer.bounds
        let url = Bundle.main.url(forResource: "demo", withExtension: "mp4")!
        let player = AVPlayer(url: url)
        player.actionAtItemEnd = .none
        playerLayer.player = player
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupPlayerLayer()
        viewForPlayerLayer.layer.addSublayer(playerLayer)
        
        /// 添加通知
        NotificationCenter.default.addObserver(self, selector: #selector(AVPlayerLayerController.playerDidReachEndNotificationHandler(_:)), name: NSNotification.Name(rawValue: "AVPlayerItemDidPlayToEndTimeNotification"), object: player.currentItem)
    }
    
    /// 移除通知
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    /// 播放
    func play() {
        if playButton.titleLabel?.text == "Play" {
            if let resumeRate = rateBeforePause {
                player.rate = resumeRate
            } else {
                player.play()
            }
            isPlaying = true
        } else {
            rateBeforePause = player.rate
            player.pause()
            isPlaying = false
        }
        
        updatePlayButtonTitle()
        updateRateSegmentedControl()
    }
    
    /// 更新按钮的 title
    func updatePlayButtonTitle() {
        if isPlaying {
            playButton.setTitle("Pause", for: .normal)
        } else {
            playButton.setTitle("Play", for: .normal)
        }
    }
    
    
    /// 更新进度控制
    func updateRateSegmentedControl() {
        if isPlaying {
            switch player.rate {
            case 0.5:
                rateSegmentControl.selectedSegmentIndex = Rate.slowForward.rawValue
            case 1.0:
                rateSegmentControl.selectedSegmentIndex = Rate.normal.rawValue
            case 2.0:
                rateSegmentControl.selectedSegmentIndex = Rate.fasrForward.rawValue
            default:
                break
            }
        } else {
            rateSegmentControl.selectedSegmentIndex = UISegmentedControl.noSegment
        }
    }
    
    
    /// 播放结束通知
    @objc func playerDidReachEndNotificationHandler(_ notification: Notification) {
        guard let playerItem = notification.object as? AVPlayerItem else {
            return
        }
        playerItem.seek(to: CMTime.zero)
        
        if shouldLoop == false {
            player.pause()
            isPlaying = false
            updatePlayButtonTitle()
            updateRateSegmentedControl()
        }
    }

    
    /// 播放暂停按钮
    @IBAction func playButtonAction(_ sender: UIButton) {
        play()
    }

    /// 进度控制
    @IBAction func rateSegmentControlValueChanged(_ sender: UISegmentedControl) {
        var rate: Float!
        switch sender.selectedSegmentIndex {
        case Rate.slowForward.rawValue:
            rate = 0.5
        case Rate.fasrForward.rawValue:
            rate = 2
        default:
            rate = 1
        }
        
        player.rate = rate
        isPlaying = true
        rateBeforePause = rate
        updatePlayButtonTitle()
    }

    /// 设置循环播放
    @IBAction func loopSwitchValueChanged(_ sender: UISwitch) {
        shouldLoop = sender.isOn
        if shouldLoop {
            player.actionAtItemEnd = .none
        } else {
            player.actionAtItemEnd = .pause
        }
    }
    /// 设置声音
    @IBAction func volumeSliderValueChanged(_ sender: UISlider) {
        player.volume = sender.value
    }

}
