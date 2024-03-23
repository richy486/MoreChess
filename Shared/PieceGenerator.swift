//
//  PieceGenerator.swift
//  MoreChess
//
//  Created by Richard Adem on 1/30/24.
//

import Foundation

struct PieceGenerator {
  static func randomPiece(movingDown: Bool, horizontalSize: Int, verticalSize: Int) -> Piece {
    let validMoves: [GridCoordinate] = [
      GridCoordinate(column: 0, row: Int.random(in: 1...3)),
    ]
    return Piece(icon: String(UnicodeScalar(Array(0x1F300...0x1F3F0).randomElement()!)!),
                 movingDown: movingDown,
                 validMoves: validMoves)
  }
  
  private static func move() -> GridCoordinate {
    // Has to move horizontally or vertically or both
    // any direction?
    // set distance or unlimited
    enum Directions: CaseIterable {
      case horizontal
      case vertical
      case both
    }
    let directions = Directions.allCases.randomElement()!
    switch directions {
    case .horizontal:
      return GridCoordinate(column: Bool.random() ? Int.random(in: 1...3) : Int.max, row: 0)
    case .vertical:
      return GridCoordinate(column: 0, row: Bool.random() ? Int.random(in: 1...3) : Int.max)
    case .both:
      return GridCoordinate(column: Bool.random() ? Int.random(in: 1...3) : Int.max,
                          row: Bool.random() ? Int.random(in: 1...3) : Int.max)
    }
  }
}

enum Pieces {
  // Knight
  static func 🐴(_ movingDown: Bool) -> Piece {
    return Piece(icon: "🐴", movingDown: movingDown, validMoves: [
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
  static func 🤴(_ movingDown: Bool) -> Piece {
    return Piece(icon: "🤴", movingDown: movingDown, validMoves: [
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
  static func 👸(_ movingDown: Bool) -> Piece {
    return Piece(icon: "👸", movingDown: movingDown, validMoves: [
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
  static func 🏰(_ movingDown: Bool) -> Piece {
    return Piece(icon: "🏰", movingDown: movingDown, validMoves: [
      GridCoordinate(column: 0, row: Int.max),
      GridCoordinate(column: 0, row: -Int.max),
      GridCoordinate(column: Int.max, row: 0),
      GridCoordinate(column: -Int.max, row: 0),
    ])
  }
  // Bishop
  static func 🥷(_ movingDown: Bool) -> Piece {
    return Piece(icon: "🥷", movingDown: movingDown, validMoves: [
      GridCoordinate(column: Int.max, row: Int.max),
      GridCoordinate(column: -Int.max, row: -Int.max),
      GridCoordinate(column: Int.max, row: -Int.max),
      GridCoordinate(column: -Int.max, row: Int.max),
    ])
  }
  static func 📍(_ movingDown: Bool) -> Piece {
    return Piece(icon: "📍", movingDown: movingDown, validMoves: [
      GridCoordinate(column: 1, row: 1),
      GridCoordinate(column: -1, row: 1)
    ])
  }
  static func 👉(_ movingDown: Bool) -> Piece {
    return Piece(icon: "👉", movingDown: movingDown, validMoves: [GridCoordinate(column: 1, row: 1)])
  }
  static func 🍴(_ movingDown: Bool) -> Piece {
    return Piece(icon: "🍴", movingDown: movingDown, validMoves: [
      GridCoordinate(column: 1, row: Int.max),
      GridCoordinate(column: -1, row: Int.max),
      GridCoordinate(column: 1, row: -Int.max),
      GridCoordinate(column: -1, row: -Int.max),
    ])
  }
}
