//
//  FacadeDomestika.swift
//  Domestika
//
//  Created by Enrique Blasco Blanquer on 09/11/2019.
//  Copyright © 2019 eblasco. All rights reserved.
//

import UIKit
import BaseLibrary

class FacadeDomestika:  FacadeBase {
    
    static let instance = FacadeDomestika()
    
    override init() {
        super.init()
        facadeName = "course"
        facade = FacadeCourse.instance
    }
    
    func getCourses() throws -> Array<Course>
    {
        return try Execute(ParseCourse(), command: "courses") as! Array<Course>
    }
    
    
}
