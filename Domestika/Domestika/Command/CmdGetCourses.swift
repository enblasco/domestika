//
//  CmdGetCourses.swift
//  Domestika
//
//  Created by Enrique Blasco Blanquer on 09/11/2019.
//  Copyright © 2019 eblasco. All rights reserved.
//

import UIKit
import BaseLibrary

/**
 CommandBase extending class
 execute background task. We call to get courses
 */
class CmdGetCourses: CommandBase {
    var courses:Array<Course>?
    let trailer = FacadeTrailers.instance
    override init()
    {
        super.init()
        self.errorMessage = "Error getting courses, try again." //error message
    }
    
    override func execute() throws {
        courses = try trailer.getCourses()
    }
    
}
