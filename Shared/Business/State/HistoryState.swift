//
//  HistoryState.swift
//  MoreChess
//
//  Created by Richard Adem on 25/01/2025.
//

import Foundation

@Observable class HistoryState {
  var history: [GameHistory] = []

  func wins(for player: Player) -> Int {
    history.reduce(0) { partialResult, gameHistory in
      switch gameHistory.playCondition {
      case .win(let winningPlayer):
        return partialResult + (player == winningPlayer ? 1 : 0)
      case .tie:
        return partialResult + 1
      default:
        return partialResult
      }
    }
  }
}

struct GameHistory {
  let board: Board2<GamePiece?>
  let playCondition: PlayCondition
  let players: [Player]

  let dateCreated = Date()
}
