//
//  UIButton+cornerRadius.swift
//  Domestika
//
//  Created by Enrique Blasco Blanquer on 09/11/2019.
//  Copyright © 2019 eblasco. All rights reserved.
//

import UIKit

@IBDesignable extension UIButton {

    @IBInspectable var borderWidthView: CGFloat {
        set {
            layer.borderWidth = newValue
        }
        get {
            return layer.borderWidth
        }
    }

    @IBInspectable var cornerRadiusView: CGFloat {
        set {
            layer.cornerRadius = newValue
        }
        get {
            return layer.cornerRadius
        }
    }

    @IBInspectable var borderColorView: UIColor? {
        set {
            guard let uiColor = newValue else { return }
            layer.borderColor = uiColor.cgColor
        }
        get {
            guard let color = layer.borderColor else { return nil }
            return UIColor(cgColor: color)
        }
    }
}
