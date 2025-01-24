//
//  PieceBase.swift
//  MoreChess
//
//  Created by Richard Adem on 24/01/2025.
//

/// Piece with rules and icon used to build a `GamePiece`.
struct PieceBase {
  let icon: Character
  let validMoves: [GridCoordinate]
}
