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
    var id:NSNumber?
    var thumbnailUrl:String?
    var title:String?
    var trailerUrl:String?
    var descript:String?
    var location:String?
    var lessonsCount:NSNumber?
    var students:NSNumber?
    var audio:String?
    var subtitles:Array<String>?
    
    func toJson() -> Dictionary<String, AnyObject>
    {
        var json = Dictionary<String, AnyObject>()
        json["id"] = id!
        json["thumbnailUrl"] = thumbnailUrl! as AnyObject?
        json["title"] = title as AnyObject
        return json
    }
}
