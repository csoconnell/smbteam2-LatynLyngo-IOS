//
//  Double+Conversions.swift
//  LatinLingo
//
//  Created by NewAgeSMB on 1/21/17.
//  Copyright © 2017 NewAgeSMB. All rights reserved.
//

import Foundation

extension Double {
    
    func celsiusToFahrenheit() -> Double {
        return self * 9 / 5 + 32
    }
    
    func fahrenheitToCelsius() -> Double {
        return (self - 32) * 5 / 9
    }
}
