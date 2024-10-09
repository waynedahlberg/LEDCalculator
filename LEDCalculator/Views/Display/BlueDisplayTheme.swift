//
//  BlueDisplayTheme.swift
//  KBDCalc
//
//  Created by Wayne Dahlberg on 3/6/24.
//

import SwiftUI

struct BlueDisplayTheme: View {
  // Font size values
  var largeFontSize: CGFloat
  var smallFontSize: CGFloat
  
  var resultText: String
  var computeText: String
  
  let baseResultText: String = "888888888."
  let baseComputeText: String = "8888888888888888888"
    
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
      Color.black
        .edgesIgnoringSafeArea(.all)
      
      VStack(alignment: .trailing, spacing: 16) {
        HStack {
          Spacer()
          ZStack(alignment: .trailing) {
            Text(baseResultText.appending(" "))
              .foregroundStyle(.cyan.opacity(0.1))
              .font(.custom("DSEG7Classic-Regular", size: largeFontSize))
            Text(resultText.appending(" "))
              .foregroundStyle(.white)
              .font(.custom("DSEG7Classic-Regular", size: largeFontSize))
              .glow(color: .ledblue, radius: 5, opacity: 0.8)
          }
        }

        HStack {
          ZStack(alignment: .trailing) {
            Text("\u{007E}\u{007E}\u{007E}\u{007E}\u{007E}\u{007E}\u{007E}\u{007E}\u{007E}\u{007E}\u{007E}\u{007E}\u{007E}\u{007E}\u{007E}\u{007E}\u{007E}\u{007E}\u{007E}\u{007E}\u{007E}\u{007E}\u{007E}\u{007E}\u{007E}".appending(" "))
              .foregroundStyle(.cyan.opacity(0.1))
              .font(.custom("DSEG14Classic-Regular", size: smallFontSize))

            Text(computeText.appending(" "))
              .foregroundStyle(.white)
              .font(.custom("DSEG14Classic-Regular", size: smallFontSize))
              .glow(color: .ledblue, radius: 6, opacity: 0.7)
          }
          .padding(.trailing, 8)
        }
      }
      .padding(.trailing, 16.0)
      
      .overlay {
//        HexagonGridView(rows: 60, columns: 108, hexagonSize: 4, strokeColor: .black)
//          .blendMode(.sourceAtop)
//          .opacity(0.5)
        Image("hex-grid-1290")
          .resizable()
          .aspectRatio(1290/540, contentMode: .fill)
          .blendMode(.sourceAtop)
          .opacity(0.5)
          .border(Color.init(white: 0.1), width: 3, edges: .bottom)
      }
    }
  }
}

#Preview {
  BlueDisplayTheme(largeFontSize: 44, smallFontSize: 16, resultText: "12345.", computeText: "123456")
}
