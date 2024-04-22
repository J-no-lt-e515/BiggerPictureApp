//
//  Sodoku.swift
//  BiggerPicture
//
//  Created by Jake Nolte on 4/20/24.
//

import SwiftUI

struct Sodoku: View {
    @State private var sudokuBoard: [[Int]] = SudokuGenerator.generateRandomBoard()
    @State private var selectedRow: Int?
    @State private var selectedCol: Int?
    @State private var selectedNumber: Int?
    @State private var numberCounters: [Int: Int] = [:]
    
    var body: some View {
        VStack {
            ScrollView {
                VStack(spacing: 1) { // Adjust vertical spacing between rows
                    ForEach(0..<9) { row in
                        HStack(spacing: 1) { // Adjust horizontal spacing between cells
                            ForEach(0..<9) { col in
                                Button(action: {
                                    // Set selectedRow and selectedCol to the current row and column
                                    self.selectedRow = row
                                    self.selectedCol = col
                                    // If there's a number in the selected cell, highlight it
                                    self.selectedNumber = self.sudokuBoard[row][col]
                                }) {
                                    CellView(value: self.sudokuBoard[row][col], isSelected: self.selectedRow == row && self.selectedCol == col, isHighlighted: self.sudokuBoard[row][col] == self.selectedNumber)
                                }
                                
                                // Add thicker vertical lines between 3x3 squares
                                if col == 2 || col == 5 {
                                    Rectangle()
                                        .frame(width: 1, height: 30) // Adjust thickness and height
                                        .foregroundColor(.black)
                                }
                            }
                        }
                        
                        // Add thicker horizontal lines between 3x3 squares
                        if row == 2 || row == 5 {
                            Rectangle()
                                .frame(height: 1) // Adjust thickness
                                .foregroundColor(.black)
                        }
                    }
                }
                .padding(5) // Add padding to adjust overall spacing
            }
            
            // Number buttons below the Sudoku grid
            VStack(spacing: 10) {
                HStack(spacing: 10) {
                    Button(action: {
                        // Placeholder action for pencil button
                    }) {
                        Text("✏️")
                            .font(.headline)
                            .foregroundColor(.black)
                            .frame(width: 40, height: 40)
                            .background(Color.blue.opacity(0.3))
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                    }
                    ForEach(1...3, id: \.self) { number in
                        NumberButton(number: number, disabled: self.numberCounters[number, default: 0] >= 9)
                            .onTapGesture {
                                self.updateBoardWithNumber(number)
                            }
                    }
                }
                HStack(spacing: 10) {
                    Button(action: {
                        self.eraseNumber()
                    }) {
                        Text("🧽")
                            .font(.headline)
                            .foregroundColor(.black)
                            .frame(width: 40, height: 40)
                            .background(Color.blue.opacity(0.3))
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                    }
                    ForEach(4...9, id: \.self) { number in
                        NumberButton(number: number, disabled: self.numberCounters[number, default: 0] >= 9)
                            .onTapGesture {
                                self.updateBoardWithNumber(number)
                            }
                    }
                }
            }
            .padding()
            .background(Color.gray.opacity(0.3))
            .cornerRadius(10)
            .padding()
        }
    }
    
    func updateBoardWithNumber(_ number: Int) {
        if let row = selectedRow, let col = selectedCol {
            if SudokuGenerator.checkValidMove(sudokuBoard, row, col, number) {
                sudokuBoard[row][col] = number
                numberCounters[number, default: 0] += 1
            }
        }
    }
    
    func eraseNumber() {
        if let row = selectedRow, let col = selectedCol {
            let number = sudokuBoard[row][col]
            if number != 0 {
                sudokuBoard[row][col] = 0
                numberCounters[number, default: 0] -= 1
            }
        }
    }
}

struct CellView: View {
    var value: Int
    var isSelected: Bool
    var isHighlighted: Bool
    
    var body: some View {
        Text(value == 0 ? "" : "\(value)")
            .font(.title)
            .frame(width: 30, height: 30)
            .foregroundColor(.black)
            .padding(5)
            .background((value != 0 && (isSelected || isHighlighted)) ? Color.blue.opacity(0.3) : Color.clear) // Highlight if selected or if the number matches selectedNumber
            .overlay(Rectangle().stroke(Color.black, lineWidth: 1))
    }
}

struct NumberButton: View {
    var number: Int
    var disabled: Bool
    
    var body: some View {
        Text("\(number)")
            .font(.headline)
            .foregroundColor(.black)
            .frame(width: 40, height: 40)
            .background(disabled ? Color.gray : Color.blue)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .disabled(disabled)
    }
}

struct Sodoku_Previews: PreviewProvider {
    static var previews: some View {
        Sodoku()
    }
}
