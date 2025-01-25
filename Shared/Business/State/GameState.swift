//
//  GameState.swift
//  MoreChess (iOS)
//
//  Created by Richard Adem on 3/23/24.
//

import Foundation

@Observable class GameState {

  // MARK: Board
  
  // This data structure is (row, column), most of the other code is (column, row) because that is
  // (x, y).
  var board: Board = [[]]
  private let initialBoard: Board
  private var currentTurnIndex: Int = 0
  var playCondition: PlayCondition = .playing


  var rowCount: Int { return board.count }
  // calculate columns from minimum grid positions in the rows so there are no positions without an
  // array value.
  var columnCount: Int {
    return board.reduce(999, { partialResult, row in
      return min(partialResult, row.count)
    })
  }
  
  // TODO: too much calculation and errors here, refactor
  var players: [Player]

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

  init() {
    let players =  [
      Players.one(local: true),
      Players.two(local: false)
    ]
    self.players = players
    initialBoard = BoardFactory.fiveByFive.makeBoard(players: players)

    let allBoard = initialBoard.joined().compactMap { $0 }
    var uniquePieces: [Character: GamePiece] = [:]
    for piece in allBoard {
      uniquePieces[piece.pieceBase.icon] = piece
    }
    
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
}
