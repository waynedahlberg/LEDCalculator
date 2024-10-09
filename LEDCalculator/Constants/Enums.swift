//
//  Enums.swift
//  LEDCalculator
//
//  Created by Wayne Dahlberg on 10/7/24.
//

import Foundation

enum Operation {
  case add, subtract, multiply, divide, equal, percent, none
}

enum CalcButton: String {
  // numerals
  case zero =       "0"
  case one =        "1"
  case two =        "2"
  case three =      "3"
  case four =       "4"
  case five =       "5"
  case six =        "6"
  case seven =      "7"
  case eight =      "8"
  case nine =       "9"
  
  // operators etc.
  case add =        "+"
  case subtract =   "-"
  case multiply =   "×"
  case divide =     "÷"
  case equal =      "="
  case clear =      "AC"
  case decimal =    "."
  case percentage = "%"
  case negative =   "SVGnegative"
  case undo =       "SVGundo"
  
  var displayValue: String {
    switch self {
      
    case .zero:         return "SVGnumber-0"
    case .one:          return "SVGnumber-1"
    case .two:          return "SVGnumber-2"
    case .three:        return "SVGnumber-3"
    case .four:         return "SVGnumber-4"
    case .five:         return "SVGnumber-5"
    case .six:          return "SVGnumber-6"
    case .seven:        return "SVGnumber-7"
    case .eight:        return "SVGnumber-8"
    case .nine:         return "SVGnumber-9"
    case .decimal:      return "SVGdecimal"
    case .add:          return "SVGplus"
    case .subtract:     return "SVGminus"
    case .multiply:     return "SVGmultiply"
    case .divide:       return "SVGdivide"
    case .equal:        return "SVGequal"
    case .undo:         return "SVGundo"
    case .clear:        return "SVGclear"
    case .negative:     return "SVGnegative"
    case .percentage:   return "SVGpercentage"
    }
  }
}

let enumOperators: [CalcButton] = [.subtract, .add, .multiply, .divide]

let multiplySymbol: String = CalcButton.multiply.rawValue
let divisionSymbol: String = CalcButton.divide.rawValue
let additionSymbol: String = CalcButton.add.rawValue
let subtractionSymbol: String = CalcButton.subtract.rawValue

let operators: String = "\(additionSymbol)\(subtractionSymbol)\(multiplySymbol)\(divisionSymbol)"


