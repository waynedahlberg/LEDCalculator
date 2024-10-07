//
//  OP1ButtonView.swift
//  KBDCalc
//
//  Created by Wayne Dahlberg on 3/3/24.
//

import SwiftUI

struct OP1ButtonView: View {
  // Skewy key values
  let circleSize: CGFloat = 0.65
  let circleShadowSize: CGFloat = 0.80
  let shadowOpacity: CGFloat = 0.25
  let inset: CGFloat = 4.0
  
  // Character size scale
  let charSize: CGFloat = 0.325
  
  // Input variables
  var charString: String
  var charColor: Color // white
  var keyColor: Color // .clear
  
  var body: some View {
    GeometryReader { proxy in
      ZStack {        
        RoundedRectangle(cornerRadius: 7.04, style: .continuous)
          .stroke(LinearGradient(colors: [
            Color(hex: "#F4F2F0"), Color(hex: "8A8587")
          ], startPoint: .top, endPoint: .bottom), lineWidth: 1.75)
          .fill(LinearGradient(colors: [
            Color(hex: "#E2E1DD"), Color(hex: "#D8D4D3")
          ], startPoint: .topLeading, endPoint: .bottomTrailing))
          .aspectRatio(1, contentMode: .fill)
        
        Circle()
          .fill(LinearGradient(colors: [
            Color(hex: "#F5F3F1"), Color(hex: "#F4F1EE").opacity(0.001), Color(hex: "#F4F1EE").opacity(0.001)
          ], startPoint: .topLeading, endPoint: .bottomTrailing))
          .frame(width: proxy.size.width * circleShadowSize, height: proxy.size.width * circleShadowSize)
          .blur(radius: 3.5)
        
        Circle()
          .stroke(LinearGradient(colors: [
            Color(hex: "#FFFFFF"), Color(hex: "#E0E0E0"), Color(hex: "#928C87")
          ], startPoint: .topLeading, endPoint: .bottomTrailing), lineWidth: 2)
          .fill(LinearGradient(colors: [
            Color(hex: "#E4DFDF"), Color(hex: "#D9D5D2")
          ], startPoint: .topLeading, endPoint: .bottomTrailing))
          .frame(width: proxy.size.width * circleSize, height: proxy.size.width * circleSize)
          .shadow(color: Color(hex: "#E1E1E1").opacity(shadowOpacity), radius: 1, x: 0, y: 0)
          .shadow(color: Color(hex: "#857E7C").opacity(shadowOpacity), radius: 4, x: 7, y: 7)
          .shadow(color: Color(hex: "#827C7A").opacity(shadowOpacity), radius: 7, x: 2, y: 10)
          .shadow(color: Color(hex: "#827C7A").opacity(shadowOpacity), radius: 5, x: 5, y: 14)
        
        ZStack {
          Circle()
            .stroke(keyColor, lineWidth: 1.0)
            .fill(keyColor)
            .frame(width: proxy.size.width * 0.45)
          
          Image(charString)
            .resizable()
            .imageScale(.large)
            .foregroundStyle(charColor)
            .frame(width: proxy.size.width * charSize, height: proxy.size.height * charSize)
          
          
//          Text(charString)
//            .font(.system(size: 24))
//            .fontDesign(.monospaced)
//            .fontWeight(.medium)
//            .foregroundStyle(charColor)
        }
      }
    }
  }
}

#Preview {
  OP1ButtonView(charString: "M", charColor: .op1Gray, keyColor: .orange)
}
