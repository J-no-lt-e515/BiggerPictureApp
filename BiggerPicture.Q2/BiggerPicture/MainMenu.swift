//
//  MainMenu.swift
//  BiggerPicture
//
//  Created by Jake Nolte on 3/28/24.
//

import SwiftUI

struct MainMenu: View {
    @State private var isSudokuButtonPressed = false
    
    var body: some View {
        VStack(spacing: 20) {
            MainMenuButton(title: "Sudoku", action: {
                isSudokuButtonPressed = true
            })
            MainMenuButton(title: "Chess", action: {
            })
            MainMenuButton(title: "More Coming Soon", action: {
            })
        }
        .padding()
        .background(
            NavigationLink(destination: Sudoku(), isActive: $isSudokuButtonPressed) {
                EmptyView()
            }
            .hidden()
        )
    }
}

struct Sudoku: View {
    var body: some View {
        Text("Sudoku View")
    }
}

struct MainMenuButton: View {
    var title: String
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.blue)
                .cornerRadius(8)
        }
    }
}

struct MainMenu_Previews: PreviewProvider {
    static var previews: some View {
        MainMenu()
    }
}
