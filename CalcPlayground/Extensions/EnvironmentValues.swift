//
//  EnvironmentValues.swift
//  KBDCalc
//
//  Created by Wayne Dahlberg on 3/1/24.
//

import SwiftUI

private struct MainWindowSizeKey: EnvironmentKey {
  static let defaultValue: CGSize = .zero
}

extension EnvironmentValues {
  var mainWindowSize: CGSize {
    get { self[MainWindowSizeKey.self] }
    set { self[MainWindowSizeKey.self] = newValue }
  }
}
