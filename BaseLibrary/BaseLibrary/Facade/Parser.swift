//
//  Parser.swift
//  BaseLibrary
//
//  Created by Enrique Blasco Blanquer on 09/11/2019.
//  Copyright © 2019 eblasco. All rights reserved.
//

import UIKit

public protocol Parser
{
    associatedtype T
    func parse(_: AnyObject) -> T
}
