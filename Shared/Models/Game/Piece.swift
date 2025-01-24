//
//  Piece.swift
//  MoreChess
//
//  Created by Richard Adem on 1/4/24.
//

import Foundation

/// Piece that is used in the game.
struct GamePiece {
  let pieceBase: PieceBase
  let player: Player

  init(pieceBase: PieceBase, player: Player) {
    self.pieceBase = pieceBase
    self.player = player
  }

  init(icon: Character, player: Player, validMoves: [GridCoordinate]) {
    self.pieceBase = PieceBase(icon: icon, validMoves: validMoves)
    self.player = player
  }

  // TODO: Add option to pass through other pieces.
  
  var description: String {
    return pieceBase.icon.unicodeScalars
      .map { String($0.properties.name ?? "-") }
      .joined(separator: ", ")
      .capitalized
  }
}

