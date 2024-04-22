//
//  ContentView.swift
//  BiggerPicture
//
//  Created by Jake Nolte on 3/28/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            LoginView()
        }
    }
}

struct LoginView: View {
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var rememberMe: Bool = false
    @State private var isLoginSuccess = false

    var body: some View {
        VStack {
            Image("Welcome")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 300, height: 300)
                .foregroundColor(.blue)
                .padding()
            
            TextField("Username", text: $username)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .autocapitalization(.none)
            
            SecureField("Password", text: $password)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            Toggle("Remember Me", isOn: $rememberMe)
                .padding()
            
            NavigationLink(destination: MainMenu(), isActive: $isLoginSuccess) {
                //sends user to the main menu screen
                EmptyView()
            }
            .hidden()
            
            Button(action: {
                isLoginSuccess = true
            }) {
                Text("Login")
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(8)
            }
            .padding()
            
            Spacer()
        }
        .padding()
        .navigationTitle("Login")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
