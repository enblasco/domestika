//
//  CourseInfoTableViewController.swift
//  Domestika
//
//  Created by Enrique Blasco Blanquer on 11/11/2019.
//  Copyright © 2019 eblasco. All rights reserved.
//

import UIKit

class CourseInfoTableViewController: UITableViewController {
    
    @IBOutlet weak var titleCourse: UILabel!
    @IBOutlet weak var descriptionCourse: UILabel!
    @IBOutlet weak var teacherName: UILabel!
    @IBOutlet weak var city: UILabel!
    @IBOutlet weak var teacherImg: UIImageView!
    @IBOutlet weak var likeTxt: UILabel!
    @IBOutlet weak var videoTxt: UILabel!
    @IBOutlet weak var userTxt: UILabel!
    @IBOutlet weak var audioTxt: UILabel!
    @IBOutlet weak var langTxt: UILabel!
    
    
    
    
    var course:Course?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setViews()
    }
    
    private func setViews(){
        //tittle
        titleCourse.text = course?.title!
        //description
        descriptionCourse.text = course?.descript!
        //teacher
        if let teacher = course!.teacher["name"]{
            teacherName.text =  teacher.utf8DecodedString().replacingOccurrences(of: "\"", with: "")
        }else{
            teacherName.text = ""
        }
        if let avatarUrl = course!.teacher["avatarUrl"] {
            teacherImg.downloaded(from: avatarUrl.utf8DecodedString().replacingOccurrences(of: "\"", with: ""))
        }
        
        city.text = course?.location!
        
        //Likes
        if let positive = course!.reviews["positive"]{
            if let total = course!.reviews["total"]{
                let positivePercent = (Double(positive.utf8DecodedString().replacingOccurrences(of: "\"", with: ""))! * 100.0) / (Double(total.utf8DecodedString().replacingOccurrences(of: "\"", with: "")))!
                let totalUtf8 = total.utf8DecodedString().replacingOccurrences(of: "\"", with: "")
                likeTxt.text = "\(positivePercent.rounded()) Positive reviews (\(totalUtf8))"
            }else{
                likeTxt.text = ""
            }
        }else{
            likeTxt.text = ""
        }
        
        //lessons
        videoTxt.text = "\(course?.lessonsCount! ?? 0) Lessons"
        //students
        userTxt.text = "\(course?.students! ?? 0) Students"
        //audio
        audioTxt.text = "Audio: \(course?.audio! ?? "")"
        //subtitles
        langTxt.text = ""
        for lang in course!.subtitles!{
            langTxt.text = "\(langTxt.text!) \(lang)/"
        }
        langTxt.text = String(langTxt.text!.dropLast())
        
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    /*
     override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
     
     // Configure the cell...
     
     return cell
     }
     */
    
}
