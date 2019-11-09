//
//  FacadeTrailers.swift
//  Domestika
//
//  Created by Enrique Blasco Blanquer on 09/11/2019.
//  Copyright © 2019 eblasco. All rights reserved.
//

import UIKit
import BaseLibrary

class FacadeTrailers: FacadeBase {
    
    static let instance = FacadeTrailers()
    
    override init() {
        super.init()
        facadeName = "trailers"
        facade = FacadeCourse.instance
    }
    
    func getCourses() throws -> Array<Course>
    {
        return try Execute(ParseCourse(), command: "courses") as! Array<Course>
    }
}

