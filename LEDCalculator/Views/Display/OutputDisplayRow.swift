//
//  TestDisplay.swift
//  KBDCalc
//
//  Created by Wayne Dahlberg on 3/14/24.
//

import SwiftUI

struct OutputDisplayRow: View {
  var outputText: String
  let display: Display
  
  var body: some View {
    ZStack {
      display.background.edgesIgnoringSafeArea(.all)
      
      HStack {
        ZStack(alignment: .trailing) {
          Text("0000000000")
            .foregroundStyle(display.ghostDigitColor)
            .font(display.font)
            .overlay {
              Rectangle()
                .fill(LinearGradient(colors: [display.background.opacity(0.5), display.background.opacity(0.2)], startPoint: .leading, endPoint: .trailing))
            }
          
          Text(outputText)
            .foregroundStyle(display.digitColor)
            .blendMode(display.isLcd ? .normal : .screen)
            .font(display.font)
            .glow(color: display.glowColor, radius: display.isLcd ? 0 : 5, opacity: display.isLcd ? 0.0 : 0.8)
        }
      }
    }
  }
}


#Preview {
  OutputDisplayRow(outputText: "12345", display: .lcdGrayLg)
}
