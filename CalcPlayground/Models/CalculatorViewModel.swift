//
//  CalculatorViewModel.swift
//  CalcPlayground
//
//  Created by Wayne Dahlberg on 10/8/24.
//

import Foundation
import Combine

@MainActor
class CalculatorViewModel: ObservableObject {
  @Published var displayValue: String = "0"
  @Published var computeText: String = ""
  
  private var currentNumber: Decimal = 0
  private var storedNumber: Decimal?
  private var currentOperation: Operation?
  private var shouldResetDisplay: Bool = true
  
  enum Operation {
    case add, subtract, multiply, divide
  }
  
  func input(_ digit: Int) {
    if shouldResetDisplay {
      displayValue = String(digit)
      shouldResetDisplay = false
    } else {
      displayValue += String(digit)
    }
    currentNumber = Decimal(string: displayValue) ?? 0
  }
  
  func setOperation(_ operation: Operation) {
    if storedNumber != nil {
      calculateResult()
    } else {
      storedNumber = currentNumber
    }
    currentOperation = operation
    shouldResetDisplay = true
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
    
    displayValue = formatResult(result)
    self.storedNumber = result
    currentNumber = result
    currentOperation = nil
    shouldResetDisplay = true
    updateComputeText()
  }
  
  // Function Operations
  func clear() {
    displayValue = "0"
    computeText = ""
    currentNumber = 0
    storedNumber = nil
    currentOperation = nil
    shouldResetDisplay = true
  }
  
  func toggleSign() {
    if let value = Decimal(string: displayValue) {
      displayValue = formatResult(-value)
      currentNumber = -value
    }
  }
  
  func inputDecimal() {
    if !displayValue.contains(".") {
      displayValue += "."
      shouldResetDisplay = false
    }
  }
  
  func undo() {
    print("undo")
  }
  
  func inputPercentage() {
    if let value = Decimal(string: displayValue) {
      let percentValue = value / 100
      displayValue = formatResult(percentValue)
      currentNumber = percentValue
    }
  }
  
  private func formatResult(_ number: Decimal) -> String {
    let formatter = NumberFormatter()
    formatter.numberStyle = .decimal
    formatter.maximumFractionDigits = 8
    return formatter.string(from: number as NSNumber) ?? "Error"
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
}
