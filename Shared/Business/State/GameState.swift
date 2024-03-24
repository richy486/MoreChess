//
//  GameState.swift
//  MoreChess (iOS)
//
//  Created by Richard Adem on 3/23/24.
//

import Foundation

struct GameState {
  
  // MARK: Board
  
  // This data structure is (row, column), most of the other code is (column, row) because that is
  // (x, y).
  var board: Board = [[]]
  var rowCount: Int { return board.count }
  // calculate columns from minimum grid positions in the rows so there are no positions without an
  // array value.
  var columnCount: Int {
    return board.reduce(999, { partialResult, row in
      return min(partialResult, row.count)
    })
  }
  
  // MARK: Current Player
  
  // TODO: too much calculation and errors here, refactor
  var players: [Player] = [
    Players.one(local: true),
    Players.two(local: false)
  ]
  private var currentTurnIndex: Int
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
  
  var playCondition: PlayCondition
  
  init() {
    currentTurnIndex = 0
    playCondition = .playing
    
    // Init board
    let initialBoard: Board = [
      [PieceGenerator.randomPiece(forPlayer: players[1], horizontalSize: 5, verticalSize: 5), Pieces.🐴(players[1]), PieceGenerator.randomPiece(forPlayer: players[1], horizontalSize: 5, verticalSize: 5), Pieces.👉(players[1]), Pieces.🏰(players[1])],
      [nil, nil, nil, nil, nil],
      [nil, nil, nil, nil, nil],
      [nil, nil, nil, nil, nil],
      [Pieces.🐴(players[0]), Pieces.🥷(players[0]), Pieces.🤴(players[0]), Pieces.👸(players[0]), PieceGenerator.randomPiece(forPlayer: players[0], horizontalSize: 5, verticalSize: 5)],
    ]

    let allBoard = initialBoard.joined().compactMap { $0 }
    var uniquePieces: [String: Piece] = [:]
    for piece in allBoard {
      uniquePieces[piece.icon] = piece
    }

    // pieceList = Array(uniquePieces.values)
    board = initialBoard
  }
}
