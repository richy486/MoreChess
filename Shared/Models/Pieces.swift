//
//  Pieces.swift
//  MoreChess (iOS)
//
//  Created by Richard Adem on 3/23/24.
//

import Foundation

enum Pieces {
  // Knight
  static func 🐴(_ player: Player) -> Piece {
    return Piece(icon: "🐴", player: player, validMoves: [
      // down
      GridCoordinate(column: 1, row: 2),
      GridCoordinate(column: -1, row: 2),
      // left
      GridCoordinate(column: -2, row: 1),
      GridCoordinate(column: -2, row: -1),
      
      // right
      GridCoordinate(column: 2, row: 1),
      GridCoordinate(column: 2, row: -1),
      
      // up
      GridCoordinate(column: 1, row: -2),
      GridCoordinate(column: -1, row: -2)
    ])
  }
  // King
  static func 🤴(_ player: Player) -> Piece {
    return Piece(icon: "🤴", player: player, validMoves: [
      GridCoordinate(column: 0, row: 1),
      GridCoordinate(column: 0, row: -1),
      GridCoordinate(column: 1, row: 0),
      GridCoordinate(column: -1, row: 0),
      
      GridCoordinate(column: 1, row: 1),
      GridCoordinate(column: -1, row: -1),
      GridCoordinate(column: 1, row: -1),
      GridCoordinate(column: -1, row: 1),
    ])
  }
  // Queen
  static func 👸(_ player: Player) -> Piece {
    return Piece(icon: "👸", player: player, validMoves: [
      GridCoordinate(column: 0, row: Int.max),
      GridCoordinate(column: 0, row: -Int.max),
      GridCoordinate(column: Int.max, row: 0),
      GridCoordinate(column: -Int.max, row: 0),
            
      GridCoordinate(column: Int.max, row: Int.max),
      GridCoordinate(column: -Int.max, row: -Int.max),
      GridCoordinate(column: Int.max, row: -Int.max),
      GridCoordinate(column: -Int.max, row: Int.max),
    ])
  }
  // Rook
  static func 🏰(_ player: Player) -> Piece {
    return Piece(icon: "🏰", player: player, validMoves: [
      GridCoordinate(column: 0, row: Int.max),
      GridCoordinate(column: 0, row: -Int.max),
      GridCoordinate(column: Int.max, row: 0),
      GridCoordinate(column: -Int.max, row: 0),
    ])
  }
  // Bishop
  static func 🥷(_ player: Player) -> Piece {
    return Piece(icon: "🥷", player: player, validMoves: [
      GridCoordinate(column: Int.max, row: Int.max),
      GridCoordinate(column: -Int.max, row: -Int.max),
      GridCoordinate(column: Int.max, row: -Int.max),
      GridCoordinate(column: -Int.max, row: Int.max),
    ])
  }
  static func 📍(_ player: Player) -> Piece {
    return Piece(icon: "📍", player: player, validMoves: [
      GridCoordinate(column: 1, row: 1),
      GridCoordinate(column: -1, row: 1)
    ])
  }
  static func 👉(_ player: Player) -> Piece {
    return Piece(icon: "👉", player: player, validMoves: [GridCoordinate(column: 1, row: 1)])
  }
  static func 🍴(_ player: Player) -> Piece {
    return Piece(icon: "🍴", player: player, validMoves: [
      GridCoordinate(column: 1, row: Int.max),
      GridCoordinate(column: -1, row: Int.max),
      GridCoordinate(column: 1, row: -Int.max),
      GridCoordinate(column: -1, row: -Int.max),
    ])
  }
}
