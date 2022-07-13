//
//  UIViewHelper.swift
//  NewsApp
//
//  Created by Aakash Decosta on 13/07/22.
//

import UIKit

extension UIView {
    // add gradient to uiview
    func roundedCorners(_ corners: CACornerMask, radius: CGFloat) {
        layer.cornerRadius = radius
        layer.maskedCorners = corners
    }
    
    @IBInspectable var topCornersRadius: Int {
        get {
            return Int(self.layer.cornerRadius)
        }
        set {
            roundedCorners([.layerMinXMinYCorner, .layerMaxXMinYCorner],
                           radius: CGFloat(newValue))
        }
    }

    @IBInspectable var topLeftCornersRadius: Int {
        get {
            return Int(self.layer.cornerRadius)
        }
        set {
            roundedCorners([.layerMinXMinYCorner],
                           radius: CGFloat(newValue))

        }
    }

    @IBInspectable var allCornersRadius: Int {
        get {
            return Int(self.layer.cornerRadius)
        }
        set {
            roundedCorners([.layerMinXMinYCorner,
                            .layerMaxXMinYCorner,
                            .layerMaxXMaxYCorner,
                            .layerMinXMaxYCorner],
                           radius: CGFloat(newValue))
        }
    }

    @IBInspectable var bottomCornersRadius: Int {
        get {
            return Int(self.layer.cornerRadius)
        }
        set {
            roundedCorners([.layerMinXMaxYCorner, .layerMaxXMaxYCorner],
                           radius: CGFloat(newValue))
        }
    }

    @IBInspectable var bottomRightCornerRadius: Int {
        get {
            return Int(self.layer.cornerRadius)
        }
        set {
            roundedCorners([.layerMaxXMaxYCorner],
                           radius: CGFloat(newValue))
        }
    }
}

