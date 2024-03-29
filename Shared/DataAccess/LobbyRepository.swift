//
//  LobbyRepository.swift
//  MoreChess (iOS)
//
//  Created by Richard Adem on 3/24/24.
//

import Foundation

// TODO: "Facade" this with a protocol so data can be mocked.

protocol LobbyRepository {
  func createGame() async -> GameService
  func joinGame(gameService: GameService) async
  func availableGames() async -> [GameService]
  func opponentJoined(gameId: String) async -> Bool
}

actor LobbyRepositoryMock: LobbyRepository {
  
//  // DEBUG
//  static var checks = 0
  
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
//    LobbyRepository.checks += 1
//    print("checks: \(LobbyRepository.checks)")
//    return LobbyRepository.checks == 2
    
    return true
  }
}

actor LobbyRepositoryWeb: LobbyRepository {
  func createGame() async -> GameService {
    return GameService(gameId: "abc", hostId: "123host", clientId: "123Client")
  }
  func joinGame(gameService: GameService) async {
    
  }
  func availableGames() async -> [GameService] {
    let data: Data
    do {
      data = try await URLSession.shared.data(from: URL(string: "https://morechess-a3d5d-default-rtdb.europe-west1.firebasedatabase.app/games.json")!).0
    } catch {
      print(error)
      return []
    }
    let decoder = JSONDecoder()
    
    struct ClientHost: Decodable {
      let clientId: String
      let hostId: String
    }
    
    let dict: [String: ClientHost]
    do {
      dict = try decoder.decode([String: ClientHost].self, from: data)
    } catch {
      print(error)
      return []
    }
    
    let gameServices = dict.map {
      return GameService(gameId: $0.key, hostId: $0.value.hostId, clientId: $0.value.clientId)
    }
    
    return gameServices
  }
  func opponentJoined(gameId: String) async -> Bool {
    return true
  }
}
