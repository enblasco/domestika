//
//  CourseDetailViewController.swift
//  Domestika
//
//  Created by Enrique Blasco Blanquer on 10/11/2019.
//  Copyright © 2019 eblasco. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation


class CourseDetailViewController: UIViewController {
    
    @IBOutlet weak var videoView: UIView!
    @IBOutlet weak var videoHeight: NSLayoutConstraint!
    @IBOutlet weak var rewindBtn: UIButton!
    @IBOutlet weak var forwardBtn: UIButton!
    
    
    final let PERCENTOFVIDEO:CGFloat = 27
    var course:Course?
    var player : AVPlayer!
    var playerController:AVPlayerViewController?
    let seekDuration: Float64 = 10
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setViews()
        playVideo()
    }
    
    
    private func setViews(){
        self.navigationController?.setNavigationBarHidden(false, animated: true) //show navigationbar
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for:.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.layoutIfNeeded()
        
        let shareButton =   UIBarButtonItem(image: UIImage(named: "share"), style: .plain, target: self, action: #selector(share))
        self.navigationItem.rightBarButtonItem = shareButton
        
        self.videoHeight.constant = (PERCENTOFVIDEO * UIScreen.main.bounds.height) / 100
    }
    
    private func playVideo(){
        player = AVPlayer(url: URL(string: self.course!.trailerUrl!)!)
        playerController = AVPlayerViewController()
        playerController!.player = player
        playerController!.view.frame = self.videoView.frame
        self.videoView.addSubview(playerController!.view)
        self.addChild(playerController!)
        player.play()
        videoView.bringSubviewToFront(rewindBtn)
        videoView.bringSubviewToFront(forwardBtn)
    }
    
    @IBAction func fastForwardBtn(_ sender: UIButton) {
        
        if player == nil { return }
        if let duration  = player!.currentItem?.duration {
            let playerCurrentTime = CMTimeGetSeconds(player!.currentTime())
            let newTime = playerCurrentTime + seekDuration
            if newTime < CMTimeGetSeconds(duration)
            {
                let selectedTime: CMTime = CMTimeMake(value: Int64(newTime * 1000 as Float64), timescale: 1000)
                player!.seek(to: selectedTime)
            }
            player?.pause()
            player?.play()
        }
        
    }
    
    @IBAction func rewindBtn(_ sender: UIButton) {
        
        if player == nil
        {
            return
        }
        let playerCurrenTime = CMTimeGetSeconds(player!.currentTime())
        var newTime = playerCurrenTime - seekDuration
        if newTime < 0
        {
            newTime = 0
        }
        player?.pause()
        let selectedTime: CMTime = CMTimeMake(value: Int64(newTime * 1000 as Float64), timescale: 1000)
        player?.seek(to: selectedTime)
        player?.play()
    }
    
    @objc func share(){
        
    }
    
    
}
