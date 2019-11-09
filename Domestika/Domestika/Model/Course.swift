//
//  Course.swift
//  Domestika
//
//  Created by Enrique Blasco Blanquer on 09/11/2019.
//  Copyright © 2019 eblasco. All rights reserved.
//

import UIKit
import BaseLibrary

class Course: ModelBase{
    @objc var id: NSNumber? = 0
    @objc var thumbnailUrl:String? = ""
    @objc var title:String? = ""
    @objc var trailerUrl:String? = ""
    @objc var descript:String? = ""
    @objc var location:String? = ""
    @objc var lessonsCount:NSNumber? = 0
    @objc var students:NSNumber? = 0
    @objc var audio:String? = ""
    @objc var subtitles:Array<String>? = []
    @objc var teacher: Dictionary<String,String> = Dictionary()
    
}
