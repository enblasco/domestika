//
//  String+ut8decode.swift
//  Domestika
//
//  Created by Enrique Blasco Blanquer on 11/11/2019.
//  Copyright © 2019 eblasco. All rights reserved.
//

import UIKit

extension String {
    func utf8DecodedString()-> String {
         let data = self.data(using: .utf8)
         if let message = String(data: data!, encoding: .nonLossyASCII){
                return message
          }
          return ""
    }

    func utf8EncodedString()-> String {
         let messageData = self.data(using: .nonLossyASCII)
         let text = String(data: messageData!, encoding: .utf8)
        return text!
    }
}
