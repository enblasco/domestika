//
//  Execute.swift
//  BaseLibrary
//
//  Created by Enrique Blasco Blanquer on 09/11/2019.
//  Copyright © 2019 eblasco. All rights reserved.
//

import UIKit

class Execute: NSObject {
    
    var commands = Array<CommandBase>()
    
    static var INSTANCE: Execute? = nil
    
    override init (){}
    
    static func createInstance() {
        if (INSTANCE == nil) {
            INSTANCE = Execute()
        }
    }
    
    public static func getInstance() -> Execute {
        if (INSTANCE == nil)
        {
            createInstance()
        }
        return INSTANCE!
    }
    
    open func exeute(_ cmd: CommandBase, view: UIViewController)
    {
        var existe = false
        for c in commands
        {
            if(c == cmd)
            {
                existe = true
                break
            }
        }
        
        if(!existe)
        {
            commands.append(cmd)
        }
        cmd.executeTask(view)
    }
    
    func cancelCommad(_ cmd: CommandBase)
    {
        cmd.cancel = true
        removeCommand(cmd)
    }
    
    open func removeCommand(_ cmd: CommandBase)
    {
        let index = commands.firstIndex(of: cmd)
        commands.remove(at: index!)
    }
    
    open func removeCommands()
    {
        for cmd in commands{
            cancelCommad(cmd)
        }
        
    }
}
