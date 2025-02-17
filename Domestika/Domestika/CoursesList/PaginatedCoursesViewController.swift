//
//  PaginatedCoursesViewController.swift
//  Domestika
//
//  Created by Enrique Blasco Blanquer on 10/11/2019.
//  Copyright © 2019 eblasco. All rights reserved.
//

import UIKit

/**
 subview of carousel. Show the carousel course
 */
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
    
    /**
     when press in "ver curso" button
     */
    @IBAction func goToCourse(_ sender: Any) {
        setBackButton()
        let courseView:CourseDetailViewController = self.storyboard?.instantiateViewController(identifier: "courseDetail") as! CourseDetailViewController
        courseView.course = self.course
        self.navigationController?.pushViewController(courseView, animated: true)
    }
    
    /**
     configure back button
     */
    private func setBackButton(){
        let backImage = UIImage(named: "backrow")
        self.navigationController?.navigationBar.backIndicatorImage = backImage
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = backImage
        
    }
    
    
    
}
