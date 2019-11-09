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
    var courses:Array<Course>?
    override func viewDidLoad() {
        super.viewDidLoad()
        getInfo()
    }
    
    func getInfo(){
        let cmd = CmdGetCourses()
        cmd.callbacks =  CommandCallbacks(
            handlerStart: {},
            handlerFinish: {
                self.courses = cmd.courses!
                
        },
            handlerRetry: {
                self.getInfo()
        },
            handlerAccept: {
                
        }
        )
        self.execute(cmd)
    }
    
    
    
}
