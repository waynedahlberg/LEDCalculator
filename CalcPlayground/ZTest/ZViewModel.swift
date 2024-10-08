//
//  ZViewModel.swift
//  CalcPlayground
//
//  Created by Wayne Dahlberg on 10/8/24.
//

import SwiftUI
import Combine

struct ZCalculatorButton: Identifiable {
  let id: String
  let svgName: String
  let character: String
  let keyColor: Color
  let charColor: Color
  let action: ZCalculatorAction
}

enum ZCalculatorAction {
  case clear, toggleSign, percentage, undo
  case divide, multiply, subtract, add, equals
  case decimal
  case number(Int)
}

@MainActor
class ZCalculatorViewModel: ObservableObject {
  @Published var displayValue: String = "0"
  @Published var computeText: String = ""
  @Published var buttons: [[ZCalculatorButton]] = []
  
  private var currentNumber: Decimal = 0
  private var storedNumber: Decimal?
  private var currentOperation: Operation?
  private var shouldResetDisplay = true
  private var hasDecimalPoint = false
  
  private let soundManager = SoundManager.shared
  private let maxDisplayDigits = 9
  
  enum Operation {
    case add, subtract, multiply, divide
  }
  
  init() {
    setupButtons()
    preloadSounds()
  }
  
  private func preloadSounds() {
    soundManager.preloadSounds(baseName: "button_press_", count: 2)
  }
  
  private func setupButtons() {
    buttons = [
      [
        ZCalculatorButton(id: "clear", svgName: "clear", character: "C", keyColor: .orange.opacity(0.5), charColor: .op1Gray, action: .clear),
        ZCalculatorButton(id: "undo", svgName: "undo", character: "del", keyColor: .clear, charColor: .op1Gray, action: .undo),
        ZCalculatorButton(id: "percentage", svgName: "percentage", character: "%", keyColor: .clear, charColor: .op1Gray, action: .percentage),
        ZCalculatorButton(id: "divide", svgName: "divide", character: "/", keyColor: .blue.opacity(0.1), charColor: Color(hex: "003467"), action: .divide)
      ],
      [
        ZCalculatorButton(id: "7", svgName: "number-7", character: "7", keyColor: .clear, charColor: .black, action: .number(7)),
        ZCalculatorButton(id: "8", svgName: "number-8", character: "8", keyColor: .clear, charColor: .black, action: .number(8)),
        ZCalculatorButton(id: "9", svgName: "number-9", character: "9", keyColor: .clear, charColor: .black, action: .number(9)),
        ZCalculatorButton(id: "multiply", svgName: "multiply", character: "X", keyColor: .blue.opacity(0.1), charColor: Color(hex: "003467"), action: .multiply)
      ],
      [
        ZCalculatorButton(id: "4", svgName: "number-4", character: "4", keyColor: .clear, charColor: .black, action: .number(4)),
        ZCalculatorButton(id: "5", svgName: "number-5", character: "5", keyColor: .clear, charColor: .black, action: .number(5)),
        ZCalculatorButton(id: "6", svgName: "number-6", character: "6", keyColor: .clear, charColor: .black, action: .number(6)),
        ZCalculatorButton(id: "subtract", svgName: "minus", character: "-", keyColor: .blue.opacity(0.1), charColor: Color(hex: "003467"), action: .subtract)
      ],
      [
        ZCalculatorButton(id: "1", svgName: "number-1", character: "1", keyColor: .clear, charColor: .black, action: .number(1)),
        ZCalculatorButton(id: "2", svgName: "number-2", character: "2", keyColor: .clear, charColor: .black, action: .number(2)),
        ZCalculatorButton(id: "3", svgName: "number-3", character: "3", keyColor: .clear, charColor: .black, action: .number(3)),
        ZCalculatorButton(id: "add", svgName: "plus", character: "+", keyColor: .blue.opacity(0.1), charColor: Color(hex: "003467"), action: .add)
      ],
      [
        ZCalculatorButton(id: "negative", svgName: "negative", character: "-/+", keyColor: .clear, charColor: .op1Gray, action: .toggleSign),
        ZCalculatorButton(id: "0", svgName: "number-0", character: "0", keyColor: .clear, charColor: .black, action: .number(0)),
        ZCalculatorButton(id: "decimal", svgName: "decimal", character: ".", keyColor: .clear, charColor: .black, action: .decimal),
        ZCalculatorButton(id: "equals", svgName: "equal", character: "=", keyColor: .clear, charColor: .op1Gray, action: .equals)
      ]
    ]
  }
  
  private func formatResult(_ number: Decimal) -> String {
    let formatter = NumberFormatter()
    formatter.numberStyle = .decimal
    formatter.maximumFractionDigits = 8
    formatter.minimumFractionDigits = 0  // Change this to 0
    formatter.usesGroupingSeparator = false
    
    guard let formattedString = formatter.string(from: number as NSNumber) else {
      return "ERR"
    }
    
    if countSignificantDigits(in: formattedString) > maxDisplayDigits {
      return "ERR"
    }
    if hasDecimalPoint && !formattedString.contains(".") {
      return formattedString + "."
    }
    
    return formattedString
  }
  
  private func countSignificantDigits(in string: String) -> Int {
    let components = string.components(separatedBy: ".")
    let integerPart = components[0].replacingOccurrences(of: "-", with: "")
    let fractionalPart = components.count > 1 ? components[1] : ""
    
    if integerPart == "0" {
      return fractionalPart.count
    } else {
      return integerPart.count + fractionalPart.count
    }
  }
  
  private func updateDisplayValue() {
    displayValue = formatResult(currentNumber)
  }
  
  func input(_ digit: Int) {
    if shouldResetDisplay {
      currentNumber = Decimal(digit)
      shouldResetDisplay = false
      hasDecimalPoint = false
    } else {
      let currentString = formatResult(currentNumber)
      if currentString == "ERR" {
        return
      }
      
      var newString = currentString + "\(digit)"
      if hasDecimalPoint {
        newString = currentString + "\(digit)"
      } else {
        if let currentValue = Decimal(string: currentString) {
          newString = formatResult(currentValue * 10 + Decimal(digit))
        }
      }
      
      if countSignificantDigits(in: newString) <= maxDisplayDigits {
        if let newValue = Decimal(string: newString) {
          currentNumber = newValue
        }
      }
    }
    updateDisplayValue()
  }
  
  func inputDecimal() {
    if !hasDecimalPoint {
      hasDecimalPoint = true
      if shouldResetDisplay {
        currentNumber = 0
        shouldResetDisplay = false
      }
      displayValue = formatResult(currentNumber) + "."
    }
  }
  
  func clear() {
    currentNumber = 0
    storedNumber = nil
    currentOperation = nil
    shouldResetDisplay = true
    hasDecimalPoint = false
    updateDisplayValue()
    computeText = ""
  }
  
  func undo() {
    let currentString = formatResult(currentNumber)
    if currentString == "0" || currentString == "ERR" || shouldResetDisplay {
      return
    }
    
    var newString = String(currentString.dropLast())
    if newString.last == "." {
      newString = String(newString.dropLast())
      hasDecimalPoint = false
    }
    
    if newString.isEmpty || newString == "-" {
      currentNumber = 0
    } else {
      currentNumber = Decimal(string: newString) ?? 0
    }
    
    updateDisplayValue()
  }
  
  func toggleSign() {
    currentNumber = -currentNumber
    updateDisplayValue()
  }
  
  func inputPercentage() {
    currentNumber = currentNumber / 100
    updateDisplayValue()
  }
  
  func setOperation(_ operation: Operation) {
    if storedNumber != nil {
      calculateResult()
    } else {
      storedNumber = currentNumber
    }
    currentOperation = operation
    shouldResetDisplay = true
    hasDecimalPoint = false
    updateComputeText()
  }
  
  func calculateResult() {
    guard let storedNumber = storedNumber, let operation = currentOperation else { return }
    
    let result: Decimal
    switch operation {
    case .add:
      result = storedNumber + currentNumber
    case .subtract:
      result = storedNumber - currentNumber
    case .multiply:
      result = storedNumber * currentNumber
    case .divide:
      result = storedNumber / currentNumber
    }
    
    let formattedResult = formatResult(result)
    if formattedResult != "ERR" {
      currentNumber = result
      self.storedNumber = result
    } else {
      currentNumber = 0
      self.storedNumber = nil
    }
    
    currentOperation = nil
    shouldResetDisplay = true
    hasDecimalPoint = formattedResult.contains(".")
    updateDisplayValue()
    updateComputeText()
  }
  
  private func updateComputeText() {
    if let storedNumber = storedNumber, let operation = currentOperation {
      let operationSymbol: String
      switch operation {
      case .add: operationSymbol = "+"
      case .subtract: operationSymbol = "-"
      case .multiply: operationSymbol = "×"
      case .divide: operationSymbol = "÷"
      }
      computeText = "\(formatResult(storedNumber)) \(operationSymbol)"
    } else {
      computeText = ""
    }
  }
  
  func performAction(_ action: ZCalculatorAction) {
    soundManager.playRandomSound()
    
    switch action {
    case .clear:
      clear()
    case .toggleSign:
      toggleSign()
    case .percentage:
      inputPercentage()
    case .divide:
      setOperation(.divide)
    case .multiply:
      setOperation(.multiply)
    case .subtract:
      setOperation(.subtract)
    case .add:
      setOperation(.add)
    case .equals:
      calculateResult()
    case .undo:
      undo()
    case .decimal:
      inputDecimal()
    case .number(let digit):
      input(digit)
    }
  }
}
