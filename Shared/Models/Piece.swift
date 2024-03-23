//
//  Piece.swift
//  MoreChess
//
//  Created by Richard Adem on 1/4/24.
//

import Foundation

struct Piece {
  let icon: String
  let player: Player
  let validMoves: [GridCoordinate]
  
  // This blows up the system
  func drawMoves() -> String {
    let allMoves = validMoves[0...0].map { $0.draw() }.joined(separator: "\n")
    return allMoves
  }
}
