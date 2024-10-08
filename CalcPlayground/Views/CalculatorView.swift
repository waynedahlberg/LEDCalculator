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
    ["clear", "negative", "percentage", "undo"],
    ["number-7", "number-8", "number-9", "divide"],
    ["number-4", "number-5", "number-6", "multiply"],
    ["number-1", "number-2", "number-3", "minus"],
    ["decimal", "number-0", "equal","plus"]
  ]
  
  let charData: [[String]] = [
    ["AC", "-/+", "%",  "←"],
    ["7", "8", "9", "/"],
    ["4", "5", "6", "X"],
    ["1", "2", "3", "-"],
    ["←", "0", "+z", "+"]
  ]
  
  let keyColor: [[Color]] = [
    [.orange.opacity(0.1), .clear, .clear, .red.opacity(0.1)],
    [.clear, .clear, .clear, .blue.opacity(0.1)],
    [.clear, .clear, .clear, .blue.opacity(0.1)],
    [.clear, .clear, .clear, .blue.opacity(0.1)],
    [.clear, .clear, .green.opacity(0.1), .blue.opacity(0.1)]
  ]
  
  let charColor: [[Color]] = [
    [Color(hex: "835000"), .op1Gray, .op1Gray, Color(hex: "7E0700")],
    [.black, .black, .black, Color(hex: "003467")],
    [.black, .black, .black, Color(hex: "003467")],
    [.black, .black, .black, Color(hex: "003467")],
    [.black, .black, Color(hex: "005F16"), Color(hex: "003467")]
  ]
  
  var body: some View {
    ZStack {
      Rectangle()
        .fill(Color.init(white: 0.1))
        .edgesIgnoringSafeArea(.all)
      
      GeometryReader { proxy in // whole screen is here
        VStack(spacing: gridSpacing) {
          ZStack {
            RoundedRectangle(cornerRadius: 13.33, style: .continuous)
              .fill(.black)
//              .border(.blue, width: 10)
//              .ignoresSafeArea(edges: [.top, .bottom])
//              .overlay {
//                GeometryReader { geo in
//                  // Just for testing, prints out the dimensions of the Geometry Proxy
//                  Text("\(String(format: "%.0f", geo.size.width))" + "  ✕  " + "\(String(format: "%.0f", geo.size.height))")
//                    .position(x: geo.size.width / 2, y: geo.size.height / 2)
//                }
//              }
            VStack {
              Rectangle()
                .overlay {
                  ZStack {
                    Image("swiftinstruments")
                      .resizable()
                      .foregroundStyle(.black.opacity(0.75))
                      .aspectRatio(contentMode: .fit)
                      .frame(height: 16)
                      .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomLeading)
                      .padding(12)
                      .shadow(color: .white.opacity(0.25), radius: 0.5, x: 0, y: 0.5)
                  }
                  .background(Color.init(white: 0.15))
                }
                .border(Color.init(white: 0.18), width: 2, edges: .bottom)
//              Spacer()
              BlueDisplayTheme(
                largeFontSize: UIDevice.isTablet ? 64 : 44,
                smallFontSize: UIDevice.isTablet ? 24 : 16, resultText: "0", computeText: "")
              .aspectRatio(2.32, contentMode: .fill)
              .frame(width: proxy.size.width)
//              .border(.green, width: 4)
            }
          }
//          .border(.yellow)
          
          Spacer() // if needed?
          
          VStack {
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
//          .border(.purple)
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
