//
//  ChatMessage.swift
//  TicTacToe (iOS)
//
//  Created by Cédric Bahirwe on 27/05/2021.
//

import UIKit

struct ChatMessage: Identifiable, Equatable, Codable {
  var id = UUID()
  let displayName: String
  let body: String
  var time = Date()

  var isUser: Bool {
    return displayName == UIDevice.current.name
  }
}
