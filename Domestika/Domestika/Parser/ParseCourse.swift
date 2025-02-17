//
//  ParseCourse.swift
//  Domestika
//
//  Created by Enrique Blasco Blanquer on 09/11/2019.
//  Copyright © 2019 eblasco. All rights reserved.
//

import UIKit
import BaseLibrary

/**
 parse json  and instance course object
 */
class ParseCourse: Parser {
    
    typealias T =  Array<Course>
    
    //reaad json
    func parse(_ jsonObject: AnyObject) -> Array<Course> {
        let array = jsonObject as! NSArray
        var courses: Array<Course> = []
        for a in array{
            courses.append(parseCourse(a as! NSDictionary))
        }
        return courses
    }
    
    //parse information
    func parseCourse(_ jsonDictionary: NSDictionary) -> Course{
        let course = Course()
        course.parseJson(jsonDictionary)
        return course
    }}
