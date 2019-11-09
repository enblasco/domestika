//
//  LoginViewController.swift
//  Domestika
//
//  Created by Enrique Blasco Blanquer on 09/11/2019.
//  Copyright © 2019 eblasco. All rights reserved.
//

import UIKit
import AVFoundation

class LoginViewController: UIViewController {

    @IBOutlet weak var lblOne: UILabel!
    @IBOutlet weak var lblTwo: UILabel!
    @IBOutlet weak var lblThree: UILabel!
    
    var avPlayer:AVPlayer?
    var avPlayerLayer: AVPlayerLayer!
    var paused: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        playBackgoundVideo()
        startAnimation()
    }
    
    private func startAnimation(){
        lblOne.fadeIn(duration: 0.5, delay: 1.0, completion: {_ in
            self.lblTwo.fadeIn(duration: 0.5, delay: 0.0, completion: {_ in
                self.lblThree.fadeIn(duration: 0.5, delay: 0.0, completion: {_ in
                })
            })
        })
    }
    
    private func playBackgoundVideo() {
    
        let theURL = Bundle.main.url(forResource:"loginvideo", withExtension: "mp4")

        avPlayer = AVPlayer(url: theURL!)
        avPlayerLayer = AVPlayerLayer(player: avPlayer)
        avPlayerLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        avPlayer!.volume = 0
        avPlayer!.actionAtItemEnd = .none

        avPlayerLayer.frame = view.layer.bounds
        view.backgroundColor = .clear
        view.layer.insertSublayer(avPlayerLayer, at: 0)

        NotificationCenter.default.addObserver(self,
                                           selector: #selector(playerItemDidReachEnd(notification:)),
                                           name: NSNotification.Name.AVPlayerItemDidPlayToEndTime,
                                           object: avPlayer?.currentItem)
    }
    
    @objc func playerItemDidReachEnd(notification: Notification) {
        let p: AVPlayerItem = notification.object as! AVPlayerItem
        p.seek(to: CMTime.zero, completionHandler: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        avPlayer!.play()
        paused = false
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        avPlayer!.pause()
        paused = true
    }
}
