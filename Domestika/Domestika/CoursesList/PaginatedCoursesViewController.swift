//
//  PaginatedCoursesViewController.swift
//  Domestika
//
//  Created by Enrique Blasco Blanquer on 10/11/2019.
//  Copyright © 2019 eblasco. All rights reserved.
//

import UIKit

class PaginatedCoursesViewController: UIViewController {

    @IBOutlet weak var imgCourse: UIImageView!
    @IBOutlet weak var lblCourse: UILabel!
    var course:Course?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setViews()
    }
    
    private func setViews(){
        lblCourse.text = course?.title!
        imgCourse.downloaded(from: (course?.thumbnailUrl!)!)
    }

}
