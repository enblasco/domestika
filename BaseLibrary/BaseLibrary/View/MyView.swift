//
//  MyView.swift
//  BaseLibrary
//
//  Created by Enrique Blasco Blanquer on 09/11/2019.
//  Copyright © 2019 eblasco. All rights reserved.
//

import UIKit

open class MyView: UIViewController {
    
    open var progress: UIActivityIndicatorView?
    open var contenedor: UIView?
    open var executer: Execute?
    
    open override func viewDidLoad() {
        executer = Execute.getInstance()
        createView()
    }
    
    open override func viewWillAppear(_ animated: Bool) {
        prepareView()
    }
    
    open override func viewWillDisappear(_ animated: Bool) {
        executer!.removeCommands()
    }
    
    open func showProgress(_ show: Bool) {
        showProgressBar(show)
        showContenedor(show)
    }
    
    open func showProgressBar(_ show: Bool)
    {
        if(progress != nil)
        {
            if(show)
            {
                progress!.startAnimating()
                progress!.isHidden = false
                
            }
            else
            {
                progress!.stopAnimating()
                progress!.isHidden = true
            }
            
        }
        
    }
    
    open func showContenedor(_ show: Bool)
    {
        if(contenedor != nil)
        {
            contenedor!.isHidden = show
        }
    }
    
    
    open func createView(){
        showProgress(false)
        setTitles()
    }
    
    open func prepareView(){}
    
    open func setTitles(){}
    
    open func execute(_ cmd: CommandBase)
    {
        executer!.exeute(cmd, view: self)
    }
    
    open func launchSegue(_ segue: String){
        performSegue(withIdentifier: segue, sender: self)
    }
    
    open func launchSegue(_ segue: String, sender: AnyObject?)
    {
        performSegue(withIdentifier: segue, sender: sender)
    }
    
    
}
