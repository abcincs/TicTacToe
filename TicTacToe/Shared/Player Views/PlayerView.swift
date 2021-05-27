//
//  PlayerView.swift
//  TicTacToe (iOS)
//
//  Created by Cédric Bahirwe on 27/05/2021.
//

import SwiftUI

struct PlayView: View {
    let player: PlayerModel
    
    var body: some View {
        List {
            HStack {
                Label(
                    title: {
                        Text("Due Date")
                            .font(.headline)
                    },
                    icon: {
                        Image(systemName: "calendar")
                    })
                Spacer()
                Text("layer.duedate")
            }
            HStack {
                Label(
                    title: {
                        Text("Payout")
                            .font(.headline)
                    },
                    icon: {
                        Image(systemName: "creditcard")
                    })
                Spacer()
                Text("player.payout")
            }
            Section(
                header: HStack(spacing: 8) {
                    Text("Available Employees")
                    Spacer()
                    ProgressView()
                }) {
                EmptyView()
            }
        }
        .listStyle(InsetGroupedListStyle())
        .navigationTitle(player.username)
    }
}

#if DEBUG
struct PlayView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            PlayView(player: PlayerModel(name: "Test Job", image: Data.init()))
        }
    }
}
#endif
