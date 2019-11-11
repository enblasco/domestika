//
//  Double+rounded.swift
//  Domestika
//
//  Created by Enrique Blasco Blanquer on 11/11/2019.
//  Copyright © 2019 eblasco. All rights reserved.
//

import UIKit

extension Double {
    /// Rounds the double to decimal places value
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(100.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
