//
//  CourseDetailViewController.swift
//  Domestika
//
//  Created by Enrique Blasco Blanquer on 10/11/2019.
//  Copyright © 2019 eblasco. All rights reserved.
//

import UIKit

class CourseDetailViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setViews()
    }
    
    private func setViews(){
        self.navigationController?.setNavigationBarHidden(false, animated: true) //show navigationbar
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for:.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.layoutIfNeeded()

        let shareButton =   UIBarButtonItem(image: UIImage(named: "share"), style: .plain, target: self, action: #selector(share))
        self.navigationItem.rightBarButtonItem = shareButton
    }
    
    @objc func share(){
        print("hola");
    }
 
   
}
