//
//  FacadeDomestika.swift
//  Domestika
//
//  Created by Enrique Blasco Blanquer on 09/11/2019.
//  Copyright © 2019 eblasco. All rights reserved.
//

import UIKit
import BaseLibrary


/**
 Prepare session to send post and get calls
 */
class FacadeDomestika: FacadeClient, URLSessionDelegate {
    static let instance = FacadeDomestika()
    let HOST = "https://my-json-server.typicode.com/emilioicai/"
    
    override func WriteResponseToStream(_ facade: String, command: String, argsMessage: String!, datos: inout AnyObject?) throws{
        
        //make the url
        let url = HOST+facade+"/"+command
        
        //instance request
        let req = NSMutableURLRequest(url: URL(string: url)!)
        
        //cconfigure request
        req.httpMethod = GET
        req.timeoutInterval = 10 //timeout
        
        let config = URLSessionConfiguration.default
        let session = Foundation.URLSession(configuration:config, delegate: self, delegateQueue:nil)
        
        //send call
        let (data, res, error) = session.synchronousDataTaskWithRequest(req as URLRequest)
        
        //analice the result
        if(error == nil)
        {
            if(res!.statusCode == 555 || res!.statusCode == 200){
                if(res!.statusCode == 555){
                    throw ErrorFacade.serverError("")
                }else{
                    if self.setJSON(data!) != nil{
                        datos =  self.setJSON(data!)! //all is ok!!!! read json
                    }
                }
            }else{
                throw ErrorFacade.serverError(String(data: data!, encoding: String.Encoding.utf8)!)
            }
        }else{
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
