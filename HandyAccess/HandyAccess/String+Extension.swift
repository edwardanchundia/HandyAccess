//
//  String+Extension.swift
//  HandyAccess
//
//  Created by Ana Ma on 2/20/17.
//  Copyright © 2017 NYCHandyAccess. All rights reserved.
//

import Foundation

extension String {
    
    var googleGeocodingSearchValue: String {
        return components(separatedBy: .punctuationCharacters).joined(separator: "+").replacingOccurrences(of: " ", with: "+")
    }

}
