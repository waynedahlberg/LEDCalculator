//
//  Extension+Double.swift
//  KBDCalc
//
//  Created by Wayne Dahlberg on 3/6/24.
//

import Foundation

extension Double {
  func formatted(withDecimalPlaces places: Int) -> String? {
    let numberFormatter = NumberFormatter()
    numberFormatter.numberStyle = .decimal
    numberFormatter.minimumFractionDigits = 0 // As few as needed
    numberFormatter.maximumFractionDigits = places // Up to `places` decimal places
    return numberFormatter.string(from: NSNumber(value: self))
  }
  
  func rounded(toPlaces places: Int) -> Double {
    let divisor = pow(10.0, Double(places))
    return (self * divisor).rounded() / divisor
  }
}
