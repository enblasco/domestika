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

/**
 course detail
 */
class CourseDetailViewController: UIViewController {
    
    @IBOutlet weak var videoView: UIView!//video view
    @IBOutlet weak var videoHeight: NSLayoutConstraint! //video height
    @IBOutlet weak var rewindBtn: UIButton!//rewind button
    @IBOutlet weak var forwardBtn: UIButton!//forward button
    
    
    final let PERCENTOFVIDEO:CGFloat = 27 //constant to determine the percent of video view in relation of the screen
    var course:Course? //course object
    var player : AVPlayer! //player
    var playerController:AVPlayerViewController? //playercontroller
    let seekDuration: Float64 = 10 //seek duration in seconds
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setViews()
        playVideo()
    }
    
    /**
     configure navigation controller.
     */
    private func setViews(){
        //show navigationbar
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        //hidde navigationbar shadow
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for:.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.layoutIfNeeded()
        
        //add shared button
        let shareButton =   UIBarButtonItem(image: UIImage(named: "share"), style: .plain, target: self, action: #selector(share))
        self.navigationItem.rightBarButtonItem = shareButton
        
        //video height
        self.videoHeight.constant = (PERCENTOFVIDEO * UIScreen.main.bounds.height) / 100
    }
    
    /**
     insert video in view and play
     */
    private func playVideo(){
        //instance player from trailer url
        player = AVPlayer(url: URL(string: self.course!.trailerUrl!)!)
        //instance playercontroller
        playerController = AVPlayerViewController()
        playerController!.player = player
        playerController!.view.frame = self.videoView.frame
        //add video in view container
        self.videoView.addSubview(playerController!.view)
        self.addChild(playerController!)
        //play
        player.play()
        //add rewind and forward buttons
        videoView.bringSubviewToFront(rewindBtn)
        videoView.bringSubviewToFront(forwardBtn)
    }
    
    /**
     forward action
     */
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
    
    /**
     rewind action
     */
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
    
    /**
     The rest of the information is shown in an embedded view. We send the info to the table view
     */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let ident = segue.identifier ?? ""
        if ident == "courseInfo" {
            let courseInfo:CourseInfoTableViewController = segue.destination as! CourseInfoTableViewController
            courseInfo.course = self.course!
        }
    }
    
    
}
