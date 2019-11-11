//
//  ModelBase.swift
//  BaseLibrary
//
//  Created by Enrique Blasco Blanquer on 09/11/2019.
//  Copyright © 2019 eblasco. All rights reserved.
//

import UIKit


/**
 Complex class. The end is to create model objects that are automatically assigned the value of json in its corresponding attribute
 If there is no property of json in the model, we do not assign value. This prevents backend errors.
 we facilitate the assignment of values ​​from json to a model object
 */
open class ModelBase: NSObject {
    
    /**
     We read json and compare  value with model atribute
     */
    open func parseJson(_ json: NSDictionary){
        //create dictonary from object model (objc atributes needed)
        let dictionary = generateDictionary()
        //compare json property with object model atribute
        for (key, value) in dictionary{
            //solved reserved word problem
            if key == "descript" {
                castType(value, value:  json["description"] as AnyObject?, property: "descript")
            }else{
                castType(value, value: json[key] as AnyObject?, property: key)
            }
            
        }
        
    }
    
    /**
     create dictonary from object model (objc atributes needed)
     */
    func generateDictionary() -> Dictionary<String,String>{
        var dictionary = Dictionary<String, String>()
        let mirror = Mirror(reflecting: self)
        for child in mirror.children {
            dictionary[child.label!] = String(describing: type(of: (child.value)))
            if((dictionary[child.label!]?.lowercased().contains("optional"))!){
                let typeArr = dictionary[child.label!]!.split(separator: "<").map(String.init)
                let typeArr2 = typeArr[1].split(separator: ">").map(String.init)
                dictionary[child.label!] = typeArr2[0]
            }
        }
        return dictionary
    }
    
    /**
     cast json types and we asign property json in corresponding object model atribute
     */
    func castType(_ type: String, value: AnyObject?, property: String){
        
        let v = nullToNil(value)
        
        if(v != nil){
            var val = toString(value!)
            switch(type){
            case "String":
                setValue(val, forKey: property)
                break
            case "Array":
                val = val.replacingOccurrences(of: "(\n", with: "")
                val = val.replacingOccurrences(of: "\n)", with: "")
                val = val.replacingOccurrences(of: "    ", with: "")
                let array = val.components(separatedBy: ",\n")
                setValue(array, forKey: property)
                break
            case "Dictionary<String, String>":
                val = val.replacingOccurrences(of: "{\n", with: "")
                val = val.replacingOccurrences(of: "\n}", with: "")
                val = val.replacingOccurrences(of: "    ", with: "")
                let array = val.components(separatedBy: ";\n")
                var dictionary: Dictionary<String, String> = Dictionary()
                for a in array{
                    let data = a.components(separatedBy: " = ")
                    dictionary[data[0].replacingOccurrences(of: ";", with: "")] = data[1].replacingOccurrences(of: ";", with: "")
                }
                setValue(dictionary, forKey: property)
                break
                
            case "NSNumber":
                let nVal = Double(val)!
                if(nVal.truncatingRemainder(dividingBy: 1) == 0) {
                    setValue(NSNumber(value: Int(nVal) as Int), forKey: property)
                }else{
                    setValue(NSNumber(value: nVal as Double), forKey: property)
                }
                break
            default:
                break
            }
        }
    }
    
    /**
     determine if value is null
     */
    func nullToNil(_ value : AnyObject?) -> AnyObject? {
        if value is NSNull {
            return nil
        } else {
            return value
        }
    }
    
    /**
     to string function
     */
    func toString(_ value: AnyObject) -> String{
        return "\(value)"
    }
    
    /**
     to boolean value
     */
    func toBool(_ value: String) -> Bool? {
        switch (value){
        case "True", "true", "yes", "1":
            return true
        case "False", "false", "no", "0":
            return false
        default:
            return nil
        }
    }
}

