//
//  WelcomeView.swift
//  TicTacToe
//
//  Created by Cédric Bahirwe on 26/05/2021.
//

import SwiftUI

struct WelcomeView: View {
    @State private var username: String = ""
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color.red, Color.blue]), startPoint: .leading, endPoint: .trailing)
                    .mask(
                        Text(username)
                            .font(.system(size: 38, weight: .bold, design: .monospaced))
                            .lineLimit(1)
                            .truncationMode(.head)
                            .frame(maxWidth: .infinity)
                            .blur(radius: 0.6)
                            .offset(y: -100)
                    )
                    .overlay(Color.white.opacity(0.9))
                
                VStack(alignment: .leading) {
                    Spacer()
                    Text("Welcome")
                        .font(.system(size: 38, weight: .bold, design: .monospaced))
                    Spacer()
                    VStack {
                        TextField("Enter your username", text: $username)
                            .textContentType(.username)
                            .autocapitalization(.none)
                            .disableAutocorrection(true)
                            .font(.system(size: 24, weight: .medium, design: .monospaced))
                        Color.primary.frame(height: 1)
                    }
                    
                    Spacer()
                    
                    HStack {
                        Spacer()
                        NavigationLink(
                            destination: GameView(username: username)) {
                            Circle()
                                .fill(Color.primary)
                                .frame(width: 80, height: 80)
                                .overlay(
                                    Image(systemName: "arrow.right")
                                        .imageScale(.large)
                                        .font(.headline)
                                        .foregroundColor(Color(.systemBackground))
                                )
                        }
                        .disabled(username.isEmpty)
                    }
                    Spacer()
                }
                .padding()
                .navigationTitle("")
                .navigationBarHidden(true)
            }
            .onChange(of: username, perform: { value in
                if value.count > 15 {
                    username = String(value.prefix(15))
                }
            })
            .ignoresSafeArea(/*@START_MENU_TOKEN@*/.keyboard/*@END_MENU_TOKEN@*/, edges: .all)
        }
        
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
