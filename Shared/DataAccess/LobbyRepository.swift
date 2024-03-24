//
//  LobbyRepository.swift
//  MoreChess (iOS)
//
//  Created by Richard Adem on 3/24/24.
//

import Foundation

// TODO: "Facade" this with a protocol so data can be mocked.

struct LobbyRepository {
  
  // DEBUG
  static var checks = 0
  
  func createGame() async -> GameService {
    return GameService(gameId: "abc", hostId: "123host", clientId: "123Client")
  }
  func joinGame(gameService: GameService) async {
    
  }
  func availableGames() async -> [GameService] {
    return [
      GameService(gameId: "abc", hostId: "123host", clientId: "123Client"),
      GameService(gameId: "def", hostId: "123host", clientId: "123Client"),
      GameService(gameId: "ghi", hostId: "123host", clientId: "123Client")
    ]
  }
  func opponentJoined(gameId: String) async -> Bool {
    try? await Task.sleep(nanoseconds: UInt64(1 * Double(NSEC_PER_SEC)))
    
    // DEBUG
    LobbyRepository.checks += 1
    print("checks: \(LobbyRepository.checks)")
    return LobbyRepository.checks == 2
  }
}
