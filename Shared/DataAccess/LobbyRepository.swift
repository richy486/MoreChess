//
//  LobbyRepository.swift
//  MoreChess (iOS)
//
//  Created by Richard Adem on 3/24/24.
//

import Foundation

// TODO: "Facade" this with a protocol so data can be mocked.

struct LobbyRepository {
  func createGame() async -> GameService {
    return GameService(gameId: "abc", hostId: "123host", clientId: "123Client")
  }
  func joinGame() {}
  func availableGames() async -> [GameService] {
    return [
      GameService(gameId: "abc", hostId: "123host", clientId: "123Client"),
      GameService(gameId: "def", hostId: "123host", clientId: "123Client"),
      GameService(gameId: "ghi", hostId: "123host", clientId: "123Client")      
    ]
  }
}
