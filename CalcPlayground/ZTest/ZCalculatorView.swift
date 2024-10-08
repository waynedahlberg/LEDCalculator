//
//  ZCalculatorView.swift
//  CalcPlayground
//
//  Created by Wayne Dahlberg on 10/8/24.
//

import SwiftUI

struct ZCalculatorView: View {
  @StateObject private var viewModel = ZCalculatorViewModel()
  @Environment(\.horizontalSizeClass) var horizontalSizeClass
  @Environment(\.verticalSizeClass) var verticalSizeClass
  
  let keyPadMargin: CGFloat = 16
  let gridSpacing: CGFloat = 4
  
  var body: some View {
    ZStack {
      Rectangle()
        .fill(Color.init(white: 0.1))
        .edgesIgnoringSafeArea(.all)
      
      GeometryReader { proxy in
        VStack(spacing: gridSpacing) {
          ZStack {
            RoundedRectangle(cornerRadius: 13.33, style: .continuous)
              .fill(.black)
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
              BlueDisplayTheme(largeFontSize: UIDevice.isTablet ? 64 : 44, smallFontSize: UIDevice.isTablet ? 24 : 16, resultText: viewModel.displayValue, computeText: viewModel.computeText)
                .aspectRatio(2.32, contentMode: .fill)
                .frame(width: proxy.size.width) // borked it
            }
          }
          
          Spacer()
          
          VStack {
                      ForEach(Array(viewModel.buttons.enumerated()), id: \.offset) { row, buttons in
                        HStack(spacing: gridSpacing) {
                          ForEach(buttons) { button in
                            Button(action: {
                              Haptics.shared.play(.light)
                              viewModel.performAction(button.action)
                            }, label: {
                              OP1ButtonView(charString: button.svgName,
                                            charColor: button.charColor,
                                            keyColor: button.keyColor)
                              .frame(width: horizontalSizeClass == .compact ? (proxy.size.width - keyPadMargin) / 4 : 128,
                                     height: horizontalSizeClass == .compact ? (proxy.size.width - keyPadMargin) / 4 : 128,
                                     alignment: .center)
                            })
                            .buttonStyle(CalcButtonStyle())
                          }
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
          }

#Preview {
  ZCalculatorView()
}
