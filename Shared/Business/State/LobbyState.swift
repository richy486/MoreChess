//
//  LobbyState.swift
//  MoreChess (iOS)
//
//  Created by Richard Adem on 3/24/24.
//

import Foundation

struct LobbyState {
  
  enum LobbyPages: Hashable {
    case host(gameService: GameService)
    case client
  }
  var path: [LobbyPages] = []
  
  
  var serviceType: ServiceType? = nil
  var availableGames: [GameService] = []
  
  var inGame: Bool {
    return serviceType != nil
  }
}
