//
//  GameState.swift
//  MoreChess (iOS)
//
//  Created by Richard Adem on 3/23/24.
//

import Foundation

@Observable class GameState {

  // This data structure is (row, column), most of the other code is (column, row) because that is
  // (x, y).
  var board: Board2<GamePiece?>
  private let initialBoard: Board2<GamePiece?>
  private var currentTurnIndex: Int = 0
  var playCondition: PlayCondition = .playing
  var players: [Player]
  // TODO: Add move history to store late in a `GameHistory`.
  // TODO: Add game start time to store late in a `GameHistory`.

  // Probably can call the board values directly.
  var rowCount: Int { board.rows }
  var columnCount: Int { board.columns }

  var currentTurn: Player {
    get {
      return players[currentTurnIndex]
    }
    set {
      guard let index = players.firstIndex(of: newValue) else {
        fatalError("no index of player")
      }
      currentTurnIndex = index
    }
  }

  var currentOpponent: Player {
    switch currentTurnIndex {
    case 0:
      return players[1]
    case 1:
      return players[0]
    default:
      fatalError("currentTurnIndex out of range")
    }
  }

  var uniquePieces: [Character: GamePiece] {
    let allBoard = initialBoard.grid.compactMap { $0 }
    var uniquePieces: [Character: GamePiece] = [:]
    for piece in allBoard {
      uniquePieces[piece.pieceBase.icon] = piece
    }
    return uniquePieces
  }

  init() {
    let players =  [
      Players.one(local: true),
      Players.two(local: false)
    ]
    self.players = players
    initialBoard = BoardFactory.fiveByFive.makeBoard(players: players)
    board = initialBoard

    for piece in uniquePieces {
      print("\(piece.key) \(piece.value.description)")
    }

    setInitialGameState()
  }

  func setInitialGameState() {
    print("setInitialGameState")
    currentTurnIndex = 0
    playCondition = .playing
    board = initialBoard
  }

  func generateAGameHistory() -> GameHistory {
    GameHistory(board: board, playCondition: playCondition, players: players)
  }
}
