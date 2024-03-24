//
//  LobbyInteractor.swift
//  MoreChess (iOS)
//
//  Created by Richard Adem on 3/24/24.
//

import Foundation

// TODO: "Facade" this with a protocol so data can be mocked.

class LobbyInteractor {
  let appState: AppState
  let lobbyRepository = LobbyRepository()
  
  init(appState: AppState) {
    self.appState = appState
  }
  
  func select(serviceType: ServiceType) {
    switch serviceType {
    case .host:
      Task {
        let gameService = await lobbyRepository.createGame()
        appState.lobbyState.path.append(.host(gameService: gameService))
      }
    case .client:
      appState.lobbyState.path.append(.client)
    }
    
  }
  
  func fetchAvailableGames() {
    Task {
      appState.lobbyState.availableGames = await lobbyRepository.availableGames()
    }
  }
}
