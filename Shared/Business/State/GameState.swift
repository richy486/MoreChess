//
//  GameState.swift
//  MoreChess (iOS)
//
//  Created by Richard Adem on 3/23/24.
//

import Foundation

struct GameState {
  // This data structure is (row, column), most of the other code is (column, row) because that is (x, y).
  var board: [[Piece?]] = [[]]

  var rowCount: Int { return board.count }
  var columnCount: Int {
    return board.reduce(999, { partialResult, row in
      return min(partialResult, row.count)
    })
  }
  
  init() {
    // Init board
    let initialBoard: [[Piece?]] = [
      [PieceGenerator.randomPiece(movingDown: true, horizontalSize: 5, verticalSize: 5), Pieces.🐴(true), PieceGenerator.randomPiece(movingDown: true, horizontalSize: 5, verticalSize: 5), Pieces.👉(true), Pieces.🏰(true)],
      [nil, nil, nil, nil, nil],
      [nil, nil, nil, nil, nil],
      [nil, nil, nil, nil, nil],
      [Pieces.🐴(false), Pieces.🥷(false), Pieces.🤴(false), Pieces.👸(false), PieceGenerator.randomPiece(movingDown: false, horizontalSize: 5, verticalSize: 5)],
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
