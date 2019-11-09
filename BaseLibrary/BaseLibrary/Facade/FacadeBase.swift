//
//  FacadeBase.swift
//  BaseLibrary
//
//  Created by Enrique Blasco Blanquer on 09/11/2019.
//  Copyright © 2019 eblasco. All rights reserved.
//

import UIKit

class FacadeBase: NSObject {
    
    open var facadeName = ""
    open var facade: FacadeClient?
    
    open func Execute<T:Parser>(_ parser: T?, command: String, args: AnyObject...) throws -> AnyObject?
    {
        return try facade!.Execute(parser, facade: facadeName, command: command, args: args as AnyObject)
    }
    
}
