//
//  ZCalculatorView.swift
//  CalcPlayground
//
//  Created by Wayne Dahlberg on 10/8/24.
//

import SwiftUI

enum DisplayTheme {
  case red
  case green
  case blue
}

struct CalculatorView: View {
  @StateObject private var viewModel = CalculatorViewModel()
  @Environment(\.horizontalSizeClass) var horizontalSizeClass
  @Environment(\.verticalSizeClass) var verticalSizeClass
  @State private var selectedTheme: DisplayTheme = .blue
  
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
                    
                    HStack(spacing: 16) {
                      Toggle(isOn: $viewModel.isMuted) {
                        EmptyView()
                      }
                      
                      Toggle("", isOn: Binding(
                        get: { selectedTheme == .red },
                        set: { if $0 { selectedTheme = .red }}
                      ))
                      .toggleStyle(ColorToggleStyle(color: .red))
                      .glow(color: selectedTheme == .red ? .red : .clear, radius: 0.5, opacity: 1)

                      
                      Toggle("", isOn: Binding(
                        get: { selectedTheme == .green },
                        set: { if $0 { selectedTheme = .green }}
                      ))
                      .toggleStyle(ColorToggleStyle(color: .green))
                      .glow(color: selectedTheme == .green ? .green : .clear, radius: 0.5, opacity: 1)

                      
                      Toggle("", isOn: Binding(
                        get: { selectedTheme == .blue },
                        set: { if $0 { selectedTheme = .blue }}
                      ))
                      .toggleStyle(ColorToggleStyle(color: .blue))
                      .glow(color: selectedTheme == .blue ? .blue : .clear, radius: 0.5, opacity: 1)
                    }
                    .padding(.bottom, 32)
                    .padding(.trailing, 16)
                    .frame(height: 30)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
                  }
                  .background(Color.init(white: 0.15))
                }
                .border(Color.init(white: 0.18), width: 2, edges: .bottom)
              
              Group {
                switch selectedTheme {
                case .red:
                  RedDisplayTheme(
                    largeFontSize: UIDevice.isTablet ? 64 : 44,
                    smallFontSize: UIDevice.isTablet ? 24 : 16,
                    resultText: viewModel.displayValue,
                    computeText: viewModel.computeText)
                  .aspectRatio(2.32, contentMode: .fill)
                  .frame(width: proxy.size.width)
                case .green:
                  GreenDisplayTheme(
                    largeFontSize: UIDevice.isTablet ? 64 : 44,
                    smallFontSize: UIDevice.isTablet ? 24 : 16,
                    resultText: viewModel.displayValue,
                    computeText: viewModel.computeText)
                  .aspectRatio(2.32, contentMode: .fill)
                  .frame(width: proxy.size.width)
                case .blue:
                  BlueDisplayTheme(
                    largeFontSize: UIDevice.isTablet ? 64 : 44,
                    smallFontSize: UIDevice.isTablet ? 24 : 16,
                    resultText: viewModel.displayValue,
                    computeText: viewModel.computeText)
                  .aspectRatio(2.32, contentMode: .fill)
                  .frame(width: proxy.size.width)
                }
              }
            }
          }
          
          Spacer()
          
          VStack(spacing: gridSpacing) {
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
  
  private var helloView: some View {
    Text("Hello")
  }
}

struct ColorToggleStyle: ToggleStyle {
  let color: Color
  
  func makeBody(configuration: Configuration) -> some View {
    RoundedRectangle(cornerRadius: 4)
      .fill(configuration.isOn ? color : color.opacity(0.2))
      .frame(width: 30, height: 30)
      .overlay(
        RoundedRectangle(cornerRadius: 4)
          .stroke(color, lineWidth: 2)
      )
      .onTapGesture {
        configuration.isOn.toggle()
      }
  }
}

#Preview {
  CalculatorView()
}
