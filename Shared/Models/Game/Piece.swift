//
//  Piece.swift
//  MoreChess
//
//  Created by Richard Adem on 1/4/24.
//

import Foundation

struct Piece {
  let icon: Character
  let player: Player
  let validMoves: [GridCoordinate]
  
  // TODO: Add option to pass through other pieces.
  
  var description: String {
    return icon.unicodeScalars
      .map { String($0.properties.name ?? "-") }
      .joined(separator: ", ")
      .capitalized
  }
}

