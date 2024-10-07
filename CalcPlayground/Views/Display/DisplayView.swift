//
//  DisplayView.swift
//  KBDCalc
//
//  Created by Wayne Dahlberg on 3/13/24.
//

import SwiftUI

enum LEDFont: String {
  case light, regular, bold, smallCompute
  
  var fontType: String {
    switch self {
    case .light: return "DSEG7Classic-LightItalic"
    case .regular: return "DSEG7ClassicMini-Italic"
    case .bold: return "DSEG7Classic-Regular"
    case .smallCompute: return "DSEG14ClassicMini-Italic"
    }
  }
}


struct DisplayView: View {
  
  // Font size values
  var resultText: String
  var computeText: String
  
  let ghostResultText: String = "888888888."
  let ghostComputeText: String = "\u{007E}\u{007E}\u{007E}\u{007E}\u{007E}\u{007E}\u{007E}\u{007E}\u{007E}\u{007E}\u{007E}\u{007E}\u{007E}\u{007E}\u{007E}\u{007E}\u{007E}\u{007E}\u{007E}\u{007E}\u{007E}\u{007E}\u{007E}\u{007E}"
  
  var body: some View {
    ZStack {
      Color.black
        .edgesIgnoringSafeArea(.all)
      
      
//      ZStack(alignment: .trailing) {
//        Text(ghostResultText.appending(" "))
//          .foregroundStyle(.red.opacity(0.1))
//          .font(.custom("DSEG7Classic-LightItalic", size: largeFontSize))
//        Text(resultText.appending(" "))
//          .foregroundStyle(.white)
//          .blendMode(.screen)
//          .font(.custom("DSEG7Classic-LightItalic", size: largeFontSize))
//          .glow(color: .ledred, radius:5, opacity: 0.55)
//      }
      
      
      
      VStack(alignment: .trailing, spacing: 16) {
        HStack {
          Spacer()
          ZStack(alignment: .trailing) {
            Text(ghostResultText)
              .led(type: .largeRedGhost)
            Text(resultText)
              .led(type: .largeRed)
          }
        }
        
        HStack {
          ZStack(alignment: .trailing) {
            Text(ghostComputeText)
              .led(type: .smallRedGhost)
            Text(computeText)
              .led(type: .smallRed)
          }
          .onAppear {
            print("\(LEDType.largeRed.style.rawValue)")
          }
        }
      }
    }
  }
}

#Preview {
  DisplayView(resultText: "0.", computeText: "0")
}


struct LEDModifier: ViewModifier {
  var ledType: LEDType
  
  func body(content: Content) -> some View {
    ZStack {
      content
        .opacity(ledType.isLit ? 1.0 : 0.05)
        .foregroundStyle(ledType.baseColor)
        .font(.custom(ledType.style.fontType, size: ledType.style == .smallCompute ? 16 : 44))
        .glow(
          color: ledType.isLit ? ledType.baseColor : .clear,
          radius: ledType.style == .smallCompute ? 8 : 5,
          opacity: ledType.style == .smallCompute ? 0.65 : 0.55
        )
    }
  }
}

extension View {
  func led(type: LEDType) -> some View {
    modifier(LEDModifier(ledType: type))
  }
}

enum SevenSegSize: CGFloat {
  case small = 16
  case large = 44
}

struct LEDType: Identifiable {
  var id = UUID()
  var isLit: Bool
  var size: SevenSegSize
  var baseColor: Color
  var style: LEDFont
  
  static let largeRed = LEDType(isLit: true, size: .large, baseColor: .red, style: .light)
  static let smallRed = LEDType(isLit: true, size: .small, baseColor: .red, style: .smallCompute)
  static let largeGreen = LEDType(isLit: true, size: .large, baseColor: .green, style: .bold)
  static let smallGreen = LEDType(isLit: true, size: .small, baseColor: .green, style: .smallCompute)
  static let largeBlue = LEDType(isLit: true, size: .large, baseColor: .blue, style: .regular)
  static let smallBlue = LEDType(isLit: true, size: .small, baseColor: .blue, style: .smallCompute)
  
  static let largeRedGhost = LEDType(isLit: false, size: .large, baseColor: .red, style: .light)
  static let smallRedGhost = LEDType(isLit: false, size: .small, baseColor: .red, style: .smallCompute)
  static let largeGreenGhost = LEDType(isLit: false, size: .large, baseColor: .green, style: .bold)
  static let smallGreenGhost = LEDType(isLit: false, size: .small, baseColor: .green, style: .smallCompute)
  static let largeBlueGhost = LEDType(isLit: false, size: .large, baseColor: .blue, style: .bold)
  static let smallBlueGhost = LEDType(isLit: false, size: .small, baseColor: .blue, style: .smallCompute)
}

extension View {
  func glow(color: Color = .ledred, radius: CGFloat = 20, opacity: CGFloat = 0.15) -> some View {
    self
      .background(self.blur(radius: radius / 6))
      .shadow(color: color.opacity(opacity), radius: radius / 3)
      .shadow(color: color.opacity(opacity), radius: radius * 6)
      .shadow(color: color.opacity(opacity), radius: radius * 2.5)
      .shadow(color: color.opacity(opacity), radius: radius)
  }
}
