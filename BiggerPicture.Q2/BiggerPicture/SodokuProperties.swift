//
//  SodokuProperties.swift
//  BiggerPicture
//
//  Created by Jake Nolte on 4/21/24.
//

import Foundation

struct SudokuGenerator {
    static func generateRandomBoard() -> [[Int]] {
        var board = Array(repeating: Array(repeating: 0, count: 9), count: 9)
        solveSudoku(&board)
        return board
    }
    
    static func solveSudoku(_ board: inout [[Int]]) -> Bool {
        for row in 0..<9 {
            for col in 0..<9 {
                if board[row][col] == 0 {
                    for num in 1...9 {
                        if isValid(board, row, col, num) {
                            board[row][col] = num
                            if solveSudoku(&board) {
                                return true
                            }
                            board[row][col] = 0
                        }
                    }
                    return false
                }
            }
        }
        return true
    }
    
    static func isValid(_ board: [[Int]], _ row: Int, _ col: Int, _ num: Int) -> Bool {
        for i in 0..<9 {
            if board[row][i] == num || board[i][col] == num || board[3 * (row / 3) + i / 3][3 * (col / 3) + i % 3] == num {
                return false
            }
        }
        return true
    }
    
    static func printBoard(_ board: [[Int]]) {
        for row in board {
            print(row)
        }
    }
    
    static func checkValidMove(_ board: [[Int]], _ row: Int, _ col: Int, _ num: Int) -> Bool {
        if num == 0 {
            return true
        }
        
        for i in 0..<9 {
            if board[row][i] == num || board[i][col] == num || board[3 * (row / 3) + i / 3][3 * (col / 3) + i % 3] == num {
                return false
            }
        }
        return true
    }
}
