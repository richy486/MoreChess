//
//  LobbyState.swift
//  MoreChess (iOS)
//
//  Created by Richard Adem on 3/24/24.
//

import Foundation

@Observable class LobbyState {
  
  enum LobbyPages: Hashable {
    case host(gameService: GameService)
    case client
  }
  var path: [LobbyPages] = []
  
  var availableGames: [GameService] = []
  var currentGameService: GameService? = nil
  
  var inGame: Bool {
    return currentGameService != nil
  }
}
