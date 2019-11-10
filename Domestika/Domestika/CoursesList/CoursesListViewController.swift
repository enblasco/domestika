//
//  CoursesListViewController.swift
//  Domestika
//
//  Created by Enrique Blasco Blanquer on 09/11/2019.
//  Copyright © 2019 eblasco. All rights reserved.
//

import UIKit
import BaseLibrary

class CoursesListViewController: MyView , UICollectionViewDelegate, UICollectionViewDataSource{
    
    
    
    @IBOutlet weak var lblSelectedCourses: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var heightCoursesPage: NSLayoutConstraint!
    
    var courses:Array<Course>? = []
    final let NUMCURSESINTOP:Int = 4
    final let PERCENTOFTOPPAGE:CGFloat = 43
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setViews()
        getInfo()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: true) //hidde navigationbar
    }
    
    private func setViews(){
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.heightCoursesPage.constant = (PERCENTOFTOPPAGE * UIScreen.main.bounds.height) / 100
        self.progress = UIActivityIndicatorView(style: .large)
        self.progress?.center = self.view.center
        self.progress?.hidesWhenStopped = false
        self.progress?.startAnimating()
        self.view.addSubview(progress!)
    }

    func getInfo(){
        let cmd = CmdGetCourses()
        cmd.callbacks =  CommandCallbacks(
            handlerStart: {
                self.showProgress(true)
        },
            handlerFinish: {
                self.showProgress(false)
                self.courses = cmd.courses!
                self.performSegue(withIdentifier: "toCoursesPage", sender: nil)
                self.collectionView.reloadData()
                self.lblSelectedCourses.isHidden = false
        },
            handlerRetry: {
                self.getInfo()
        },
            handlerAccept: {
                
        }
        )
        self.execute(cmd)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if self.courses!.count > NUMCURSESINTOP {
            return Array(self.courses![NUMCURSESINTOP...self.courses!.count-1]).count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "courseCell", for: indexPath) as! CourseCollectionViewCell
        cell.bottomHeight.constant = (cell.bounds.height * 50.0)/100
        cell.viewContainer.dropShadow()
        let course = courses![NUMCURSESINTOP + indexPath.row]
        cell.imgCourse.downloaded(from: course.thumbnailUrl!)
        cell.titleCourse.text = course.title!
        if let teacher = course.teacher["name"]{
            cell.teacherCourse.text =  teacher.utf8DecodedString().replacingOccurrences(of: "\"", with: "")
        }else{
            cell.teacherCourse.text = ""
        }
       
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
  
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let ident = segue.identifier ?? ""
        if ident == "toCoursesPage" {
            let coursesPage:CoursesPageViewController = segue.destination as! CoursesPageViewController
            
            coursesPage.coursesList = Array(self.courses![0...NUMCURSESINTOP-1])
        }
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String?, sender: Any?) -> Bool {
        if let ident = identifier {
            if ident == "toCoursesPage" {
                if self.courses?.count == 0 {
                    return false
                }
            }
        }
        return true
    }
    
    
}
extension CoursesListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        print("\(indexPath.row)")
        return CGSize(width: (78.0 * UIScreen.main.bounds.width) / 100, height: collectionView.bounds.height)
    }
    

}
