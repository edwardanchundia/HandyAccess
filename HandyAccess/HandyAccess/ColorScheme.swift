//
//  ColorScheme.swift
//  HandyAccess
//
//  Created by Ana Ma on 2/19/17.
//  Copyright © 2017 NYCHandyAccess. All rights reserved.
//

import Foundation
import UIKit

class ColorScheme {
    var _50 = UIColor(red:0.88, green:0.96, blue:1.00, alpha:1.0)
    var _100 = UIColor(red:0.70, green:0.90, blue:0.99, alpha:1.0)
    var _200 = UIColor(red:0.51, green:0.83, blue:0.98, alpha:1.0)
    var _300 = UIColor(red:0.31, green:0.76, blue:0.97, alpha:1.0)
    var _400 = UIColor(red:0.16, green:0.71, blue:0.96, alpha:1.0)
    var _500 = UIColor(red:0.01, green:0.66, blue:0.96, alpha:1.0)
    var _600 = UIColor(red:0.01, green:0.61, blue:0.90, alpha:1.0)
    var _700 = UIColor(red:0.01, green:0.53, blue:0.82, alpha:1.0)
    var _800 = UIColor(red:0.01, green:0.47, blue:0.74, alpha:1.0)
    var _900 = UIColor(red:0.00, green:0.34, blue:0.61, alpha:1.0)
    
    var A100 = UIColor(red:0.50, green:0.85, blue:1.00, alpha:1.0)
    var A200 = UIColor(red:0.25, green:0.77, blue:1.00, alpha:1.0)
    var A400 = UIColor(red:0.00, green:0.69, blue:1.00, alpha:1.0)
    var A700 = UIColor(red:0.00, green:0.57, blue:0.92, alpha:1.0)
    
    var primary: UIColor {
        get {
            return _500
        }
    }
    
    var primaryLight: UIColor {
        get {
            return _100
        }
    }
    
    var primaryDark: UIColor {
        get {
            return _700
        }
    }
    
    var colorSchemeArr: [UIColor] {
        get {
            return [_50, _200, _400, _600, _400, _200]
        }
    }

//    var primaryLight = UIColor(red:0.58, green:0.78, blue:0.99, alpha:1.0)
//    var primary = UIColor(red:0.29, green:0.60, blue:0.98, alpha:1.0)
//    var primaryDark = UIColor(red:0.13, green:0.26, blue:0.42, alpha:1.0)
//    var primaryDarkBlack = UIColor(red:0.25, green:0.33, blue:0.42, alpha:1.0)
//    var primarySky = UIColor(red:0.22, green:0.46, blue:0.76, alpha:1.0)
    
}
