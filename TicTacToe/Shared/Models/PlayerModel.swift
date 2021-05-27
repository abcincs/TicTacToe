//
//  PlayerModel.swift
//  TicTacToe (iOS)
//
//  Created by Cédric Bahirwe on 27/05/2021.
//

import Foundation

class PlayerListStore: ObservableObject {
  @Published var players: [PlayerModel] = []
}

struct PlayerModel: Codable, Identifiable {
  var id = UUID()
  let username: String
  let image: Data

  init(name: String, image: Data) {
    self.username = name
    self.image = image
  }

  func data() -> Data? {
    let encoder = JSONEncoder()
    return try? encoder.encode(self)
  }
}
