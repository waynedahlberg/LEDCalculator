//
//  iPadSupport.swift
//  KBDCalc
//
//  Created by Wayne Dahlberg on 3/1/24.
//

import SwiftUI

extension UIDevice {
  static var isTablet: Bool {
    return UIDevice.current.userInterfaceIdiom == .pad
  }
  
  static var isPhone: Bool {
    return UIDevice.current.userInterfaceIdiom == .phone
  }
}
