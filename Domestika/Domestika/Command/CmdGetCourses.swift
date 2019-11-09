//
//  CmdGetCourses.swift
//  Domestika
//
//  Created by Enrique Blasco Blanquer on 09/11/2019.
//  Copyright © 2019 eblasco. All rights reserved.
//

import UIKit
import BaseLibrary

class CmdGetCourses: CommandBase {
    var courses:Array<Course>?
    let domestika = FacadeDomestika.instance
    override init()
    {
        super.init()
        self.errorMessage = "Error getting courses, try again."
    }
    
    override func execute() throws {
        courses = try domestika.getCourses()
    }
        
}
