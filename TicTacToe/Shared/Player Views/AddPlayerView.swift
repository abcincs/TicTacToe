//
//  AddPlayerView.swift
//  TicTacToe (iOS)
//
//  Created by Cédric Bahirwe on 27/05/2021.
//

import SwiftUI

struct AddPlayerView: View {
    @EnvironmentObject var playerListStore: PlayerListStore
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State private var playerName = ""
    @State private var image = Data.init()
    
    var body: some View {
        Form { //swiftlint:disable:this trailing_closure
            TextField("Job Name", text: $playerName)
            HStack {
                Text(NumberFormatter.currency.currencySymbol)
            }
            Button("Save") {
                let player = PlayerModel(name: playerName, image: image)
                playerListStore.players.append(player)
                presentationMode.wrappedValue.dismiss()
            }
            .disabled(playerName.isEmpty)
        }
        .listStyle(InsetGroupedListStyle())
        .navigationBarTitle("Add Job", displayMode: .inline)
        .toolbar(content: {
            ToolbarItem(placement: .cancellationAction) {
                Button("Cancel") {
                    presentationMode.wrappedValue.dismiss()
                }
            }
        })
    }
}

#if DEBUG
struct AddPlayerView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            AddPlayerView()
                .environmentObject(PlayerListStore())
        }
    }
}
#endif
