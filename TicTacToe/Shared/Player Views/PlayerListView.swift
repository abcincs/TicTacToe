//
//  PlayerListView.swift
//  TicTacToe (iOS)
//
//  Created by Cédric Bahirwe on 27/05/2021.
//

import SwiftUI

struct PlayerListView: View {
    @ObservedObject var playerConnectionManager: PlayerConnectionManager
    
    @ObservedObject var playListStore: PlayerListStore
    @State private var showAddJob = false
    @State private var isReceivingJobs = false
    
    init(playListStore: PlayerListStore = PlayerListStore()) {
        self.playListStore = playListStore
        playerConnectionManager = PlayerConnectionManager { player in
            playListStore.players.append(player)
        }
    }
    
    var body: some View {
        List {
            Section(
                header: headerView,
                footer: footerView) {
                ForEach(playListStore.players) { player in
                    PlayerListRowView(player: player)
                }
                .onDelete { indexSet in
                    self.playListStore.players.remove(atOffsets: indexSet)
                }
            }
        }
        .listStyle(InsetGroupedListStyle())
        .navigationTitle("Jobs")
        .sheet(isPresented: $showAddJob) {
            NavigationView {
                AddPlayerView()
                    .environmentObject(playListStore)
            }
        }
    }
    
    var headerView: some View {
        Toggle("Receive Jobs", isOn: $isReceivingJobs)
    }
    
    var footerView: some View {
        Button(
            action: {
                showAddJob = true
            }, label: {
                Label("Add Job", systemImage: "plus.circle")
            })
    }
}

#if DEBUG
struct JobListViewPreview: PreviewProvider {
    static var previews: some View {
        NavigationView {
            PlayerListView(playListStore: PlayerListStore())
        }
    }
}
#endif
