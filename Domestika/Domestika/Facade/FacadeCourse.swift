//
//  FacadeCourse.swift
//  Domestika
//
//  Created by Enrique Blasco Blanquer on 09/11/2019.
//  Copyright © 2019 eblasco. All rights reserved.
//

import UIKit
import BaseLibrary

class FacadeCourse: FacadeClient, URLSessionDelegate {
    static let instance = FacadeCourse()
    let HOST = "https://my-json-server.typicode.com/emilioicai/trailers/"
    
    override func WriteResponseToStream(_ facade: String, command: String, argsMessage: String!, datos: inout AnyObject?) throws{
        
        let url = HOST+command
        
        let req = NSMutableURLRequest(url: URL(string: url)!)
        
        req.httpMethod = GET
        req.timeoutInterval = 10

        let config = URLSessionConfiguration.default
        let session = Foundation.URLSession(configuration:config, delegate: self, delegateQueue:nil)
        
        let (data, res, error) = session.synchronousDataTaskWithRequest(req as URLRequest)
        
        if(error == nil)
        {
            if(res!.statusCode == 555 || res!.statusCode == 200)
            {
                
                if(res!.statusCode == 555)
                {
                   throw ErrorFacade.serverError("")
                }
                else
                {
                    
                    if self.setJSON(data!) != nil
                    {
                        datos =  self.setJSON(data!)!
                    }
                }
                
            }
            else
            {
                throw ErrorFacade.serverError(String(data: data!, encoding: String.Encoding.utf8)!)
            }
        }
        else{
            throw ErrorFacade.serverError(error!.description)
        }
        
    }
    
    func URLSession(_ session: Foundation.URLSession, task: URLSessionTask, didReceiveChallenge challenge: URLAuthenticationChallenge, completionHandler: (Foundation.URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        if challenge.protectionSpace.authenticationMethod == NSURLAuthenticationMethodServerTrust {
            let credential = URLCredential(trust: challenge.protectionSpace.serverTrust!)
            completionHandler(Foundation.URLSession.AuthChallengeDisposition.useCredential, credential)
        }
    }
}

extension URLSession {
    func synchronousDataTaskWithRequest(_ url: URLRequest) -> (Data?, HTTPURLResponse?, NSError?) {
        var data: Data?, response: URLResponse?, error: NSError?
        
        let semaphore = DispatchSemaphore(value: 0)
        
        dataTask(with: url, completionHandler: {
            data = $0; response = $1; error = $2 as NSError?
            semaphore.signal()
            }).resume()
        
        _ = semaphore.wait(timeout: DispatchTime.distantFuture)
        
        return (data, response as? HTTPURLResponse, error)
    }
}
