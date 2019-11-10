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
    
    final let PERCENTOFVIDEO:CGFloat = 27
    var course:Course?
    
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
        
        self.videoHeight.constant = (PERCENTOFVIDEO * UIScreen.main.bounds.height) / 100    }
    
    private func playVideo(){
        let player = AVPlayer(url: URL(string: self.course!.trailerUrl!)!)
        let playerController:AVPlayerViewController? = AVPlayerViewController()
        playerController!.player = player
        playerController!.view.frame = self.videoView.frame
        self.videoView.addSubview(playerController!.view)
        self.addChild(playerController!)
        player.play()
        //player.seek(to: CMTime(seconds: 10.0, preferredTimescale:.zero))
    }
    
    @objc func share(){
        
    }
 
    
}
