//
//  ContentView.swift
//  Shared
//
//  Created by Cédric Bahirwe on 26/05/2021.
//

import SwiftUI

struct Item: Identifiable {
    var id = UUID()
    var hasbeenSelected = false
    var isHuman = false
    
    static let example = Item(hasbeenSelected: false, isHuman: false)
}

struct ContentView: View {
    var body: some View {
        GameView()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
