//
//  CoursesListViewController.swift
//  Domestika
//
//  Created by Enrique Blasco Blanquer on 09/11/2019.
//  Copyright © 2019 eblasco. All rights reserved.
//

import UIKit
import BaseLibrary

/**
 main class that controls the course carousel and the collectionview
 */
class CoursesListViewController: MyView , UICollectionViewDelegate, UICollectionViewDataSource{
    
    @IBOutlet weak var lblSelectedCourses: UILabel!//static text "seleccionado para ti". It is initially hidden but we show it when we get the courses
    @IBOutlet weak var collectionView: UICollectionView! //the collection view
    @IBOutlet weak var heightCoursesPage: NSLayoutConstraint! //height of top carousel. Calculate the percent in relation of the screen
    
    var courses:Array<Course>? = [] //courses array
    final let NUMCURSESINTOP:Int = 4 //constant to determine the number of courses in top carousel
    final let PERCENTOFTOPPAGE:CGFloat = 43 //constant to determine the percent of top carousel in relation of the screen
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setViews()
        getInfo()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: true) //hidde navigationbar
    }
    
    /**
     prepare and configure  collectionview, height of carousel and activity indication
     */
    private func setViews(){
        //collection view delegate
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        //height of carousel
        self.heightCoursesPage.constant = (PERCENTOFTOPPAGE * UIScreen.main.bounds.height) / 100
        //instance progress circle
        self.progress = UIActivityIndicatorView(style: .large)
        self.progress?.center = self.view.center
        self.progress?.hidesWhenStopped = false
        self.progress?.startAnimating()
        self.view.addSubview(progress!)
    }
    
    /**
     get courses
     */
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
                
        })
        self.execute(cmd)
    }
    
    // MARK: - Collection view data source
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //if have more than four courses, we print the rest in collection view
        if self.courses!.count > NUMCURSESINTOP {
            return Array(self.courses![NUMCURSESINTOP...self.courses!.count-1]).count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CourseCollectionViewCell
        
        //configure cell view
        cell.bottomHeight.constant = (cell.bounds.height * 50.0)/100 //height of bottom view in cell
        cell.viewContainer.dropShadow() //print shadow
        
        //print course in cell
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let course = courses![NUMCURSESINTOP + indexPath.row]
        let courseView:CourseDetailViewController = self.storyboard?.instantiateViewController(identifier: "courseDetail") as! CourseDetailViewController
        courseView.course = course
        self.navigationController?.pushViewController(courseView, animated: true)
    }
    
    
    /**
     show top carousel. The carousel is embebed and we manage it whit the segue
     */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let ident = segue.identifier ?? ""
        if ident == "toCoursesPage" {
            let coursesPage:CoursesPageViewController = segue.destination as! CoursesPageViewController
            
            coursesPage.coursesList = Array(self.courses![0...NUMCURSESINTOP-1])
        }
    }
    
    /**
     We canceled the show the carousel. We look forward to receiving all courses
     */
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

/**
 extensioin: Set cell height
 */
extension CoursesListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        print("\(indexPath.row)")
        return CGSize(width: (78.0 * UIScreen.main.bounds.width) / 100, height: collectionView.bounds.height)
    }
}
