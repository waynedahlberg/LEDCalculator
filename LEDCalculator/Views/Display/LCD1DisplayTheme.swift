//
//  LCD1DisplayTheme.swift
//  KBDCalc
//
//  Created by Wayne Dahlberg on 3/8/24.
//

import SwiftUI

struct LCD1DisplayTheme: View {
  // Font size values
  var largeFontSize: CGFloat
  var smallFontSize: CGFloat
  
  var resultText: String
  var computeText: String
  
  let baseResultText: String = "888888888."
  let baseComputeText: String = "888888888888888888"
  
  let screenGradient2 = LinearGradient(stops: [
    Gradient.Stop(color: Color.black.opacity(0.3), location: 0.0),
    Gradient.Stop(color: Color(hex: "#8295EF").opacity(0.10), location: 0.4),
    Gradient.Stop(color: Color(hex: "#949FD2").opacity(0.10), location: 0.859),
    Gradient.Stop(color: .clear, location: 0.89),
    Gradient.Stop(color: .clear, location: 1.0)
  ], startPoint: .top, endPoint: .bottom)
  
  let screenGradient1 = LinearGradient(colors: [
    Color(.black),
    Color(.blue.opacity(0.15))
  ], startPoint: .top, endPoint: .bottom)
  
  var body: some View {
    ZStack {
      Color(.backgroundLcd)
        .edgesIgnoringSafeArea(.all)
      
      VStack(alignment: .trailing, spacing: 16) {
        HStack {
          Spacer()
          ZStack(alignment: .trailing) {
            Text(baseResultText.appending(" "))
              .foregroundStyle(.black.opacity(0.03))
              .font(.custom("DSEG7Classic-Regular", size: largeFontSize))
            Text(resultText.appending(" "))
              .foregroundStyle(.black)
              .font(.custom("DSEG7Classic-Regular", size: largeFontSize))
          }
          .shadow(color: .black.opacity(0.25), radius: 1, x: 0.5, y: 2)
        }

        HStack {
          ZStack(alignment: .trailing) {
            Text("\u{007E}\u{007E}\u{007E}\u{007E}\u{007E}\u{007E}\u{007E}\u{007E}\u{007E}\u{007E}\u{007E}\u{007E}\u{007E}\u{007E}\u{007E}\u{007E}\u{007E}\u{007E}\u{007E}\u{007E}\u{007E}\u{007E}\u{007E}\u{007E}\u{007E}".appending(" "))              .foregroundStyle(.black.opacity(0.03))
              .font(.custom("DSEG14Classic-Regular", size: smallFontSize))
            Text(computeText.appending(" "))
              .foregroundStyle(.black)
              .font(.custom("DSEG14Classic-Regular", size: smallFontSize))
          }
          .shadow(color: .black.opacity(0.3), radius: 1, x: 2, y: 2)
        }
        .padding(.trailing, 8)
      }
      .padding(.trailing, 16.0)
//      .overlay {
////        HexagonGridView(rows: 60, columns: 108, hexagonSize: 4, strokeColor: .black)
////          .blendMode(.sourceAtop)
////          .opacity(0.5)
//        Image("hex-grid-1290")
//          .resizable()
//          .aspectRatio(1290/540, contentMode: .fill)
//          .blendMode(.sourceAtop)
//          .opacity(0.5)
//
//      }
    }
  }
}

#Preview {
    LCD1DisplayTheme(largeFontSize: 44, smallFontSize: 16, resultText: "3.1415927", computeText: "3+5*7-3/2")
}
