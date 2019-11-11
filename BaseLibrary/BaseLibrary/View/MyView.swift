//
//  MyView.swift
//  BaseLibrary
//
//  Created by Enrique Blasco Blanquer on 09/11/2019.
//  Copyright © 2019 eblasco. All rights reserved.
//

import UIKit


/**
 Base view. Contains all commond tasks
 */
open class MyView: UIViewController {
    
    open var progress: UIActivityIndicatorView?
    open var executer: Execute?
    
    open override func viewDidLoad() {
        executer = Execute.getInstance()
        createView()
    }
    
    open override func viewWillDisappear(_ animated: Bool) {
        executer!.removeCommands()
    }
    
    open func showProgress(_ show: Bool) {
        showProgressBar(show)
    }
    
    open func showProgressBar(_ show: Bool)
    {
        if(progress != nil){
            if(show){
                progress!.startAnimating()
                progress!.isHidden = false
            }else{
                progress!.stopAnimating()
                progress!.isHidden = true
            }
        }
    }
    
    open func createView(){
        showProgress(false)
    }
    
    open func execute(_ cmd: CommandBase)
    {
        executer!.exeute(cmd, view: self)
    }
    
    
    
}
