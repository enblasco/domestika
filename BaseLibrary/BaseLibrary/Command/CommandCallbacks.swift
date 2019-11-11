//
//  CommandCallbacks.swift
//  BaseLibrary
//
//  Created by Enrique Blasco Blanquer on 09/11/2019.
//  Copyright © 2019 eblasco. All rights reserved.
//

import UIKit

/**
 command callbacks
 */
open class CommandCallbacks {
    
    var retry: (() -> Void)?
    var accept: (() -> Void)?
    var start: (() -> Void)?
    var finish: (() -> Void)?
    
    open func onRetry(){
        if let _ = self.retry {
            retry!()
        }
    }
    
    open func onAccept(){
        if let _ = self.accept {
            accept!()
        }
    }
    
    open func onFinish(){
        if let _ = self.finish {
            finish!()
        }
    }
    
    open func onStart(){
        if let _ = self.start {
            start!()
        }
    }
    
    public init(handlerStart: @escaping (() -> Void), handlerFinish: @escaping (() -> Void), handlerRetry: @escaping (() -> Void), handlerAccept: @escaping (() -> Void)){
        self.retry = handlerRetry
        self.accept = handlerAccept
        self.start = handlerStart
        self.finish = handlerFinish
    }
    
}
