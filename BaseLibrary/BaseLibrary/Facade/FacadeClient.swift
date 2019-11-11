//
//  FacadeClient.swift
//  BaseLibrary
//
//  Created by Enrique Blasco Blanquer on 09/11/2019.
//  Copyright © 2019 eblasco. All rights reserved.
//

import UIKit

/**
 base class white execute task and JSON serialization
 */
open class FacadeClient: NSObject {
    public let POST = "POST"
    public let GET = "GET"
    
    public enum ErrorFacade: Error {
        case serverError(String)
    }
    
    func Execute<T:Parser>(_ parser: T?, facade: String, command: String, args: AnyObject...) throws -> AnyObject? {
        let jsonObject = try InnerExecute(facade, command: command, args: (args as AnyObject) as! Array<Any>, file: nil)
        var data: AnyObject? = nil
        if(parser != nil && jsonObject != nil){
            data = parser!.parse(jsonObject!) as AnyObject
        }else{
            data = jsonObject
        }
        
        return data
    }
    
    fileprivate func InnerExecute(_ facade: String, command: String , args: Array<Any>, file: String?) throws -> AnyObject?{
        var argsMessage: String? = ""
        var datos: AnyObject? = nil
        do {
            let data = try JSONSerialization.data(withJSONObject: args[0], options: JSONSerialization.WritingOptions(rawValue: 0))
            argsMessage = String(data: data, encoding: String.Encoding.utf8)
        }catch let error as NSError{
            print(error.description)
            throw ErrorFacade.serverError(error.description)
        }
        
        do{
            try WriteResponseToStream(facade, command: command, argsMessage: argsMessage, datos: &datos)
        }
        catch let error as NSError {
            throw ErrorFacade.serverError(error.description)
        }
        
        return datos
        
    }
    
    open func setJSON(_ datos: Data) -> AnyObject?{
        do{
            if let json = try JSONSerialization.jsonObject(with: datos, options: JSONSerialization.ReadingOptions.allowFragments) as AnyObject?{
                return json
            }
        }catch{
            return nil
        }
        return nil
    }
    
    
    open func WriteResponseToStream(_ facade: String, command: String, argsMessage: String!, datos: inout AnyObject?) throws {}
    
    
}
