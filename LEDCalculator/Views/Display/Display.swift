//
//  Display.swift
//  KBDCalc
//
//  Created by Wayne Dahlberg on 3/14/24.
//

import SwiftUI

struct Display: Identifiable {
  var id = UUID()
  let font: Font
  let digitColor: Color
  let ghostDigitColor: Color
  let glowColor: Color
  let background: Color
  var isLcd: Bool
  
  // Red display
  static let redDisplayLg: Display = Display(font: .custom("DSEG7Classic-LightItalic", size: 44), digitColor: .white, ghostDigitColor: .red.opacity(0.25), glowColor: .ledred, background: .black, isLcd: false)
  static let redDisplaySm: Display = Display(font: .custom("DSEG14ClassicMini-Italic", size: 16), digitColor: .white, ghostDigitColor: .red.opacity(0.25), glowColor: .ledred, background: .black, isLcd: false)
  
  // Green display
  static let greenDisplayLg: Display = Display(font: .custom("DSEG7Classic-Italic", size: 44), digitColor: .white, ghostDigitColor: .green.opacity(0.25), glowColor: .ledgreen, background: .black, isLcd: false)
  static let greenDisplaySm: Display = Display(font: .custom("DSEG14ClassicMini-Italic", size: 16), digitColor: .white, ghostDigitColor: .green.opacity(0.25), glowColor: .ledgreen, background: .black, isLcd: false)
  
  // Blue display
  static let blueDisplayLg: Display = Display(font: .custom("DSEG7ClassicMini-Regular", size: 44), digitColor: .white, ghostDigitColor: .blue.opacity(0.25), glowColor: .ledblue, background: .black, isLcd: false)
  static let blueDisplaySm: Display = Display(font: .custom("DSEG14ClassicMini-Italic", size: 16), digitColor: .white, ghostDigitColor: .blue.opacity(0.25), glowColor: .ledblue, background: .black, isLcd: false)
  
  // LCD gray
  static let lcdGrayLg: Display = Display(font: .custom("DSEG7ClassicMini-Italic", size: 44), digitColor: .black, ghostDigitColor: .op1Gray.opacity(0.05), glowColor: .clear, background: .backgroundLcd, isLcd: true)
  static let lcdGraySm: Display = Display(font: .custom("DSEG14ClassicMini-Italic", size: 16), digitColor: .black, ghostDigitColor: .op1Gray.opacity(0.05), glowColor: .clear, background: .backgroundLcd, isLcd: true)
  
  // LCD Indiglo
  static let lcdIndigloLg: Display = Display(font: .custom("DSEG7ClassicMini-BoldItalic", size: 44), digitColor: .black.opacity(0.8), ghostDigitColor: .op1Gray.opacity(0.05), glowColor: .clear, background: .backgroundIndiglo, isLcd: true)
  static let ldcIndigloSm: Display = Display(font: .custom("DSEG14ClassicMini-Italic", size: 16), digitColor: .black.opacity(0.8), ghostDigitColor: .op1Gray.opacity(0.05), glowColor: .clear, background: .backgroundIndiglo, isLcd: true)
}
