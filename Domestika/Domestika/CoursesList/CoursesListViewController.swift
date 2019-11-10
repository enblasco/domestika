//
//  CoursesListViewController.swift
//  Domestika
//
//  Created by Enrique Blasco Blanquer on 09/11/2019.
//  Copyright © 2019 eblasco. All rights reserved.
//

import UIKit
import BaseLibrary

class CoursesListViewController: MyView {
    
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
    
    private func setViews(){
        self.heightCoursesPage.constant = (PERCENTOFTOPPAGE * UIScreen.main.bounds.height) / 100
        self.navigationController?.setNavigationBarHidden(true, animated: true) //hidde navigationbar
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
        },
            handlerRetry: {
                self.getInfo()
        },
            handlerAccept: {
                
        }
        )
        self.execute(cmd)
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
