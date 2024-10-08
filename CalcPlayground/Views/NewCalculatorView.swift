//
//  NewCalculatorView.swift
//  CalcPlayground
//
//  Created by Wayne Dahlberg on 10/8/24.
//

import SwiftUI

struct NewCalculatorView: View {
  @StateObject private var viewModel = CalculatorViewModel()
  
  private let gridSpacing: CGFloat = 4
  private let buttonSize: CGFloat = 72
  
  private let buttons: [[CalculatorButton]] = [
    [.clear, .plusMinus, .percent, .undo],
    [.seven, .eight, .nine, .divide],
    [.four, .five, .six, .multiply],
    [.one, .two, .three, .subtract],
    [.decimal, .zero, .equal, .add]
  ]
  
  var body: some View {
    GeometryReader { geometry in
      VStack(spacing: 0) {
        Spacer(minLength: 0)
        displayView
        Spacer(minLength: 0)
        buttonPad(size: geometry.size)
      }
      .background(Color(white: 0.1))
    }
    .statusBarHidden()
    .preferredColorScheme(.dark)
    .persistentSystemOverlays(.hidden)
  }
  
  // Display View
  private var displayView: some View {
    VStack(alignment: .trailing, spacing: 8) {
      Text(viewModel.displayValue)
        .font(.system(size: 64, weight: .light))
        .minimumScaleFactor(0.5)
        .lineLimit(1)
      Text(viewModel.computeText)
        .font(.system(size: 24))
        .foregroundStyle(.gray)
    }
    .frame(maxWidth: .infinity, alignment: .trailing)
    .border(.purple)
    .background(Color.black)
  }
  
  // Button Pad View
  private func buttonPad(size: CGSize) -> some View {
    VStack(spacing: gridSpacing) {
      ForEach(buttons, id: \.self) { row in
        HStack(spacing: gridSpacing) {
          ForEach(row, id: \.self) { button in
            CalculatorButtonView(button: button, action: { self.tapped(button) })
              .frame(width: buttonSize)
          }
        }
      }
    }
    .padding(gridSpacing)
  }
  
  private func tapped(_ button: CalculatorButton) {
    switch button {
    case .undo: viewModel.undo()
    case .clear: viewModel.clear()
    case .plusMinus: viewModel.toggleSign()
    case .percent: viewModel.inputPercentage()
    case .divide: viewModel.setOperation(.divide)
    case .multiply: viewModel.setOperation(.multiply)
    case .subtract: viewModel.setOperation(.subtract)
    case .add: viewModel.setOperation(.add)
    case .equal: viewModel.calculateResult()
    case .decimal: viewModel.inputDecimal()
    case .zero, .one, .two, .three, .four, .five, .six, .seven, .eight, .nine: viewModel.input(button.rawValue)
    }
  }
}

enum CalculatorButton: Int {
  case zero, one, two, three, four, five, six, seven, eight, nine
  case decimal, equal, add, subtract, multiply, divide, undo
  case percent, plusMinus, clear
  
  var title: String {
    switch self {
      
    case .zero:
      return "number-0"
    case .one:
      return "number-1"
    case .two:
      return "number-2"
    case .three:
      return "number-3"
    case .four:
      return "number-4"
    case .five:
      return "number-5"
    case .six:
      return "number-6"
    case .seven:
      return "number-7"
    case .eight:
      return "number-8"
    case .nine:
      return "number-9"
    case .decimal:
      return "decimal"
    case .equal:
      return "equal"
    case .add:
      return "plus"
    case .subtract:
      return "minus"
    case .multiply:
      return "multiply"
    case .divide:
      return "divide"
    case .percent:
      return "percentage"
    case .plusMinus:
      return "negative"
    case .clear:
      return "clear"
    case .undo:
      return "undo"
    }
  }
  
  var color: Color {
    switch self {
    case .clear: return .orange
    case .undo: return .red
    case .equal: return .green
    case .add, .subtract, .multiply, .divide: return .blue
    default:
      return Color.clear
    }
  }
}

// Calculator Button View
struct CalculatorButtonView: View {
  let button: CalculatorButton
  let action: () -> Void
  
  var body: some View {
    Button(action: action) {
      OP1ButtonView(charString: button.title, charColor: Color.primary, keyColor: button.color)
    }
    .buttonStyle(CalcButtonStyle())
  }
}

#Preview {
  NewCalculatorView()
}
