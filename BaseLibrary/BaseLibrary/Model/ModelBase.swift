//
//  ModelBase.swift
//  BaseLibrary
//
//  Created by Enrique Blasco Blanquer on 09/11/2019.
//  Copyright © 2019 eblasco. All rights reserved.
//

import UIKit

class ModelBase: NSObject {
    open func parseJson(_ json: NSDictionary)
        {
            let dictionary = generateDictionary()
            for (key, value) in dictionary{
                if let val = json[key]
                {
                    castType(value, value: val as AnyObject?, property: key)
                }
            }
        }

        func generateDictionary() -> Dictionary<String,String>{
            var dictionary = Dictionary<String, String>()
            let mirror = Mirror(reflecting: self)
            for child in mirror.children {
                dictionary[child.label!] = String(describing: type(of: (child.value)))
            }
            return dictionary
        }
        
        func castType(_ type: String, value: AnyObject?, property: String){
            
            let v = nullToNil(value)
            
            if(v != nil){
                var val = toString(value!)
                switch(type){
                case "String":
                    setValue(val, forKey: property)
                    break
                    
                case "String, String":
                    val = val.replacingOccurrences(of: "{\n", with: "")
                    val = val.replacingOccurrences(of: "\n}", with: "")
                    val = val.replacingOccurrences(of: "    ", with: "")
                    let array = val.components(separatedBy: ";\n")
                    var dictionary: Dictionary<String, String> = Dictionary()
                    if property != "tags"{
                        for a in array{
                            let data = a.components(separatedBy: " = ")
                            dictionary[data[0].replacingOccurrences(of: ";", with: "")] = data[1].replacingOccurrences(of: ";", with: "")
                        }
                    }
                    break
                    
                case "NSNumber":
                    let nVal = Double(val)!
                    if(nVal.truncatingRemainder(dividingBy: 1) == 0)
                    {
                        setValue(NSNumber(value: Int(nVal) as Int), forKey: property)
                    }
                    else{
                        setValue(NSNumber(value: nVal as Double), forKey: property)
                    }
                    break
                    
                default:
                    break
                }
            }
        }
        
        func nullToNil(_ value : AnyObject?) -> AnyObject? {
            if value is NSNull {
                return nil
            } else {
                return value
            }
        }
        
        func toString(_ value: AnyObject) -> String{
            return "\(value)"
        }
        
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

