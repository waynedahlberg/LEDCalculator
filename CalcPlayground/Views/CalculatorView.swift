//
//  CalculatorView.swift
//  CalcPlayground
//
//  Created by Wayne Dahlberg on 10/7/24.
//

import SwiftUI

struct CalculatorView: View {
  @Environment(\.horizontalSizeClass) var horizontalSizeClass
  @Environment(\.verticalSizeClass) var verticalSizeClass
  
  let keypadMargin: CGFloat = 16
  let gridSpacing: CGFloat = 4
  
  let svgData: [[String]] = [
    ["clear", "negative", "percentage", "divide"],
    ["number-7", "number-8", "number-9", "multiply"],
    ["number-4", "number-5", "number-6", "minus"],
    ["number-1", "number-2", "number-3", "plus"],
    ["decimal", "number-0", "undo","equal"]
  ]
  
  let charData: [[String]] = [
    ["AC", "+/-", "%", "/"],
    ["7", "8", "9", "X"],
    ["4", "5", "6", "-"],
    ["1", "2", "3", "+"],
    ["←", "0", ".", "=z"]
  ]
  
  let keyColor: [[Color]] = [
    [.clear, .clear, .clear, .clear],
    [.clear, .clear, .clear, .clear],
    [.clear, .clear, .clear, .clear],
    [.clear, .clear, .clear, .clear],
    [.clear, .clear, .red.opacity(0.05), .clear]
  ]
  
  let charColor: [[Color]] = [
    [.op1Gray, .op1Gray, .op1Gray, .op1Gray],
    [.black, .black, .black, .op1Gray],
    [.black, .black, .black, .op1Gray],
    [.black, .black, .black, .op1Gray],
    [.black, .black, .red, .op1Gray]
  ]
  
  var body: some View {
    ZStack {
      Rectangle()
        .fill(Color.black)
        .edgesIgnoringSafeArea(.all)
      
      GeometryReader { proxy in // whole screen is here
        VStack(spacing: gridSpacing) {
          ZStack {
            RoundedRectangle(cornerRadius: 13.33, style: .continuous)
              .fill(.black)
              .ignoresSafeArea(edges: [.top, .bottom])
//              .overlay {
//                GeometryReader { geo in
//                  // Just for testing, prints out the dimensions of the Geometry Proxy
//                  Text("\(String(format: "%.0f", geo.size.width))" + "  ✕  " + "\(String(format: "%.0f", geo.size.height))")
//                    .position(x: geo.size.width / 2, y: geo.size.height / 2)
//                }
//              }
            VStack {
              Spacer()
              RedDisplayTheme(
                largeFontSize: UIDevice.isTablet ? 64 : 44,
                smallFontSize: UIDevice.isTablet ? 24 : 16, resultText: "3.14159265", computeText: " ")
              .aspectRatio(2.32, contentMode: .fit)
              .frame(width: proxy.size.width)
            }
          }
          
          Spacer() // if needed?
          
          ForEach(0..<5, id:\.self) { row in
            HStack(spacing: gridSpacing) {
              ForEach(0..<4, id:\.self) { rect in
                let character = svgData[row][rect]
                let charColor = charColor[row][rect]
                let keyColor = keyColor[row][rect]
                Button(action: {
                  print("b")
                  Haptics.shared.play(.light)
                }, label: {
                  OP1ButtonView(charString: character,
                                charColor: charColor,
                                keyColor: keyColor)
                  .frame(width: horizontalSizeClass == .compact ? (proxy.size.width - keypadMargin) / 4 : 128,
                         height: horizontalSizeClass == .compact ? (proxy.size.width - keypadMargin) / 4 : 128,
                         alignment: .center)
                })
                .buttonStyle(CalcButtonStyle())
              }
            }
          }
        }
        .position(x: proxy.size.width / 2, y: proxy.size.height / 2)
      }
      .edgesIgnoringSafeArea(.bottom)
    }
    .statusBarHidden()
    .preferredColorScheme(.dark)
    .persistentSystemOverlays(.hidden)
  }
  
  private func randomColor() -> Color {
    let colors: [Color] = [
      .red, .pink, .purple, .indigo, .blue, .cyan, .mint, .green, .yellow, .orange
    ]
    return colors.randomElement() ?? .red
  }
}

#Preview {
  CalculatorView()
}
