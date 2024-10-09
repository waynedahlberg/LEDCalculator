//
//  AllDisplaysView.swift
//  KBDCalc
//
//  Created by Wayne Dahlberg on 3/8/24.
//

import SwiftUI

struct AllDisplaysView: View {
  
  let largeText: CGFloat = 44
  let smallText: CGFloat = 16
  
  var resultText: String = "3.1415927"
  var computeText: String = "3 * 3 + 2 / 7"
  
    var body: some View {
      VStack(spacing: 0) {
        GreenDisplayTheme(largeFontSize: largeText, smallFontSize: smallText, resultText: resultText, computeText: computeText).frame(height: 128)
        RedDisplayTheme(largeFontSize: largeText, smallFontSize: smallText, resultText: resultText, computeText: computeText).frame(height: 128)
        BlueDisplayTheme(largeFontSize: largeText, smallFontSize: smallText, resultText: resultText, computeText: computeText).frame(height: 128)
        LCD1DisplayTheme(largeFontSize: largeText, smallFontSize: smallText, resultText: resultText, computeText: computeText).frame(height: 128)
        LCD2DisplayTheme(largeFontSize: largeText, smallFontSize: smallText, resultText: resultText, computeText: computeText).frame(height: 128)
        LCD3DisplayTheme(largeFontSize: largeText, smallFontSize: smallText, resultText: resultText, computeText: computeText).frame(height: 128)
        Spacer()
      }
    }
}

#Preview {
    AllDisplaysView()
}
