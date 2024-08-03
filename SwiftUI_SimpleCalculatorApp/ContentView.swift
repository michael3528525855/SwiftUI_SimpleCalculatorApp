//
//  ContentView.swift
//  SwiftUI_SimpleCalculatorApp
//
//  Created by michael on 31/07/2024.
//

import SwiftUI

struct ContentView: View {
    @State private var display = "0"
    let buttons: [[String]] = [
        ["7", "8", "9", "/"],
        ["4", "5", "6", "*"],
        ["1", "2", "3", "-"],
        ["0", ".", "=", "+"]
    ]
    
    
    
    
    @State private var currentNumber = ""
    @State private var previousNumber = ""
    @State private var operation: String? = nil
    
    
    
    var body: some View {
        VStack {
            
            Text("Simple Calculator App")
                .font(.largeTitle)
            Spacer()
            Text(display)
                .font(.largeTitle)
                .padding()
                .frame(maxWidth: .infinity, alignment: .trailing)
                .background(Color.gray.opacity(0.1))
            
            ForEach(buttons, id: \.self) 
            { row in
                HStack {
                    ForEach(row, id: \.self) 
                    { button in Button(action: {self.buttonTapped(button)})
                        {
                            Text(button)
                                .font(.title)
                                .frame(width: self.buttonWidth(), height: self.buttonHeight())
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                    }
                }
                .padding(.bottom, 3)
            }
        }
        .padding()
    }
    
    
    
    func buttonWidth() -> CGFloat {
        return (UIScreen.main.bounds.width - 5 * 10) / 4
    }
        
    func buttonHeight() -> CGFloat {
        return (UIScreen.main.bounds.width - 5 * 10) / 4
    }
    
    
    
    
    func buttonTapped(_ button: String) {
        switch button {
        case "0"..."9":
            currentNumber += button
            display = currentNumber
        case ".", "=", "+", "-", "*", "/":
            handleOperation(button)
        default:
            break
        }
    }
    
    func handleOperation(_ operation: String) {
        if operation == "=" {
            performCalculation()
        } else {
            self.operation = operation
            previousNumber = currentNumber
            currentNumber = ""
        }
    }
    
    func performCalculation() {
        guard let operation = operation,
              let prevNumber = Double(previousNumber),
              let currNumber = Double(currentNumber) else {
            return
        }
        
        let result: Double
        
        switch operation {
        case "+":
            result = prevNumber + currNumber
        case "-":
            result = prevNumber - currNumber
        case "*":
            result = prevNumber * currNumber
        case "/":
            result = prevNumber / currNumber
        default:
            return
        }
        
        display = String(result)
        currentNumber = String(result)
        self.operation = nil
        previousNumber = ""
    }
    
}
    


#Preview {
    ContentView()
}
