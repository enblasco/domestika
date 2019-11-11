//
//  FacadeTrailers.swift
//  Domestika
//
//  Created by Enrique Blasco Blanquer on 09/11/2019.
//  Copyright © 2019 eblasco. All rights reserved.
//

import UIKit
import BaseLibrary

/**
 Contains all calls related to the "trailers" backend
 In this case it only has one function "getCourses"
 */
class FacadeTrailers: FacadeBase {
    
    static let instance = FacadeTrailers()
    
    override init() {
        super.init()
        facadeName = "trailers"
        facade = FacadeDomestika.instance
    }
    
    /**
     get all courses
     */
    func getCourses() throws -> Array<Course>
    {
        return try Execute(ParseCourse(), command: "courses") as! Array<Course>
    }
}

