//
//  JobListRowView.swift
//  TicTacToe (iOS)
//
//  Created by Cédric Bahirwe on 27/05/2021.
//

import SwiftUI

struct PlayerListRowView: View {
    let player: PlayerModel
    
    var body: some View {
        NavigationLink(
            destination:
                PlayView(player: player)) {
            HStack {
                VStack(alignment: .leading) {
                    Text(player.username)
                        .font(.title3)
                    Text("(player.dueDate, formatter: DateFormatter.dueDateFormatter)")
                        .font(.caption)
                }
                Spacer()
                Text("player")
                    .font(.headline)
            }
        }
    }
}

#if DEBUG
struct PlayerListRowView_Previews: PreviewProvider {
    static var previews: some View {
        PlayerListRowView(player: PlayerModel(name: "Mock Job", image: .init()))
    }
}
#endif
