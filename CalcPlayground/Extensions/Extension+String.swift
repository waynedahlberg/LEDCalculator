//
//  Extension+String.swift
//  KBDCalc
//
//  Created by Wayne Dahlberg on 3/6/24.
//

import Foundation

extension String {
  func formatted(upToDecimalPlaces places: Int) -> String? {
    guard let number = Double(self) else {
      print("Invalid number string")
      return nil
    }
    
    let numberFormatter = NumberFormatter()
    numberFormatter.numberStyle = .decimal
    numberFormatter.minimumFractionDigits = 0 // As few as needed
    numberFormatter.maximumFractionDigits = places // Up to 'places' decimal places
    return numberFormatter.string(from: NSNumber(value: number))
  }
  
  func appending(_ string: String) -> String {
    return self + string 
  }
}
