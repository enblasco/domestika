//
//  CommandBase.swift
//  BaseLibrary
//
//  Created by Enrique Blasco Blanquer on 09/11/2019.
//  Copyright © 2019 eblasco. All rights reserved.
//

import UIKit
import CoreLocation

open class CommandBase: NSObject {
    open var succesMessage: String = ""
    open var needInternet: Bool = true
    open var cancel = false
    open var cancelable = true
    open var error: String = ""
    open var errorMessage: String = ""
    open var view: UIViewController?
    open var callbacks: CommandCallbacks?
    var ejecutador = Execute.getInstance()
    
    open func executeTask(_ view: UIViewController)
    {
        self.view = view
        //launch in second plane
        DispatchQueue.global().async(execute: {
            do{
                try self.execute()
            }
            catch let error as NSError {
                self.error = error.description
            }
            self.onPostExecute()
        });
    }
    
    open func execute() throws {}
    
    
    open func onPostExecute()
    {
        //launch in main threat
        DispatchQueue.main.async(execute: {
            if(!self.cancel)
            {
                if(self.error != "" && self.errorMessage != "")
                {
                    self.mostrarAviso(self.errorMessage, showRetry: true)
                }
                else
                {
                    self.Finished()
                }
            }
        });
        
    }
    
    open func isNeedInternet() -> Bool {
        return needInternet
    }
    
    
    func mostrarAviso(_ msg: String, showRetry: Bool)
    {
        let alert = UIAlertController(title: NSLocalizedString("error", comment: ""), message: msg, preferredStyle: UIAlertController.Style.alert)
        
        let retry: UIAlertAction = UIAlertAction(title: NSLocalizedString("retry", comment: ""), style: .default) { action -> Void in
            self.retry()
        }
        let accept: UIAlertAction = UIAlertAction(title: NSLocalizedString("accept", comment: ""), style: .default) { action -> Void in
            self.accept()
        }
        alert.addAction(retry)
        alert.addAction(accept)
        view!.present(alert, animated: true, completion: nil)
    }
    
    open func onCancelled() {
        if(cancelable)
        {
            cancel = true
        }
    }
    
    open func Finished(){
        if(callbacks != nil)
        {
            callbacks!.onFinish()
        }
        
    }
    
    open func Start(){
        if(callbacks != nil)
        {
            callbacks!.onStart()
        }
    }
    
    open func retry()
    {
        if(callbacks != nil)
        {
            callbacks!.onRetry()
        }
        
    }
    
    open func accept()
    {
        if(callbacks != nil)
        {
            callbacks!.onAccept()
        }
        
    }
    
}
