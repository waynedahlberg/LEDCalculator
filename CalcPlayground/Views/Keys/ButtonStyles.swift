//
//  ButtonStyles.swift
//  KBDCalc
//
//  Created by Wayne Dahlberg on 3/6/24.
//

import SwiftUI

struct CalcButtonStyle: ButtonStyle {
  var pressedScale: CGFloat = 0.9
  var animationDuration: Double = 0.1
  
  func makeBody(configuration: Configuration) -> some View {
    configuration.label
      .scaleEffect(configuration.isPressed ? pressedScale : 1.0)
      .animation(.easeInOut(duration: animationDuration), value: configuration.isPressed)
      .overlay {
        withAnimation {
          configuration.isPressed ? Color.black.opacity(0.08) : Color.clear
        }
      }
  }
}
