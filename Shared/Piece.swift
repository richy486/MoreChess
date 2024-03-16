//
//  Piece.swift
//  MoreChess
//
//  Created by Richard Adem on 1/4/24.
//

import Foundation

struct Piece {
//  static func == (lhs: Piece, rhs: Piece) -> Bool {
//    return lhs.icon == rhs.icon
////    && lhs.validMoves == rhs.validMoves
//  }
  
  let icon: String
  let movingDown: Bool
  let validMoves: [GridPosition]
  
  // This blows up the system
  func drawMoves() -> String {
    let allMoves = validMoves[0...0].map { $0.draw() }.joined(separator: "\n")
    return allMoves
  }
}
