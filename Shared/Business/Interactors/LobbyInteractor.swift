//
//  LobbyInteractor.swift
//  MoreChess (iOS)
//
//  Created by Richard Adem on 3/24/24.
//

import Foundation

// TODO: "Facade" this with a protocol so data can be mocked.

class LobbyInteractor {
  let lobbyState: LobbyState
  let lobbyRepository = LobbyRepository()
  
  init(lobbyState: LobbyState) {
    self.lobbyState = lobbyState
  }
  
  func select(serviceType: ServiceType) {
    switch serviceType {
    case .host:
      Task {
        let gameService = await lobbyRepository.createGame()
        lobbyState.path.append(.host(gameService: gameService))
      }
    case .client:
      lobbyState.path.append(.client)
    }
    
  }
  
  func fetchAvailableGames() {
    Task {
      lobbyState.availableGames = await lobbyRepository.availableGames()
    }
  }
  
  func checkForOpponentClient(gameService: GameService) {
    LobbyRepository.checks = 0
    Task {
      var resultFound = false
      while resultFound == false {
        resultFound = await lobbyRepository.opponentJoined(gameId: gameService.gameId)
      }
      
      lobbyState.currentGameService = gameService
    }
  }
  
  func joinGame(gameService: GameService) {
    Task {
      await lobbyRepository.joinGame(gameService: gameService)
      lobbyState.currentGameService = gameService
    }
  }
}
