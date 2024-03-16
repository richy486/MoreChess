//
//  PieceGenerator.swift
//  MoreChess
//
//  Created by Richard Adem on 1/30/24.
//

import Foundation

struct PieceGenerator {
  static func randomPiece(movingDown: Bool, horizontalSize: Int, verticalSize: Int) -> Piece {
    
    
    
    let validMoves: [GridPosition] = [
      GridPosition(column: 0, row: Int.random(in: 1...3)),
    ]
    return Piece(icon: String(UnicodeScalar(Array(0x1F300...0x1F3F0).randomElement()!)!),
                 movingDown: movingDown,
                 validMoves: validMoves)
  }
  
  private static func move() -> GridPosition {
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
      return GridPosition(column: Bool.random() ? Int.random(in: 1...3) : Int.max, row: 0)
    case .vertical:
      return GridPosition(column: 0, row: Bool.random() ? Int.random(in: 1...3) : Int.max)
    case .both:
      return GridPosition(column: Bool.random() ? Int.random(in: 1...3) : Int.max,
                          row: Bool.random() ? Int.random(in: 1...3) : Int.max)
    }
  }
}

enum Pieces {
  // Knight
  static func 🐴(_ movingDown: Bool) -> Piece {
    return Piece(icon: "🐴", movingDown: movingDown, validMoves: [
      // down
      GridPosition(column: 1, row: 2),
      GridPosition(column: -1, row: 2),
      // left
      GridPosition(column: -2, row: 1),
      GridPosition(column: -2, row: -1),
      
      // right
      GridPosition(column: 2, row: 1),
      GridPosition(column: 2, row: -1),
      
      // up
      GridPosition(column: 1, row: -2),
      GridPosition(column: -1, row: -2)
    ])
  }
  // King
  static func 🤴(_ movingDown: Bool) -> Piece {
    return Piece(icon: "🤴", movingDown: movingDown, validMoves: [
      GridPosition(column: 0, row: 1),
      GridPosition(column: 0, row: -1),
      GridPosition(column: 1, row: 0),
      GridPosition(column: -1, row: 0),
      
      GridPosition(column: 1, row: 1),
      GridPosition(column: -1, row: -1),
      GridPosition(column: 1, row: -1),
      GridPosition(column: -1, row: 1),
    ])
  }
  // Queen
  static func 👸(_ movingDown: Bool) -> Piece {
    return Piece(icon: "👸", movingDown: movingDown, validMoves: [
      GridPosition(column: 0, row: Int.max),
      GridPosition(column: 0, row: -Int.max),
      GridPosition(column: Int.max, row: 0),
      GridPosition(column: -Int.max, row: 0),
            
      GridPosition(column: Int.max, row: Int.max),
      GridPosition(column: -Int.max, row: -Int.max),
      GridPosition(column: Int.max, row: -Int.max),
      GridPosition(column: -Int.max, row: Int.max),
    ])
  }
  // Rook
  static func 🏰(_ movingDown: Bool) -> Piece {
    return Piece(icon: "🏰", movingDown: movingDown, validMoves: [
      GridPosition(column: 0, row: Int.max),
      GridPosition(column: 0, row: -Int.max),
      GridPosition(column: Int.max, row: 0),
      GridPosition(column: -Int.max, row: 0),
    ])
  }
  // Bishop
  static func 🥷(_ movingDown: Bool) -> Piece {
    return Piece(icon: "🥷", movingDown: movingDown, validMoves: [
      GridPosition(column: Int.max, row: Int.max),
      GridPosition(column: -Int.max, row: -Int.max),
      GridPosition(column: Int.max, row: -Int.max),
      GridPosition(column: -Int.max, row: Int.max),
    ])
  }
  static func 📍(_ movingDown: Bool) -> Piece {
    return Piece(icon: "📍", movingDown: movingDown, validMoves: [
      GridPosition(column: 1, row: 1),
      GridPosition(column: -1, row: 1)
    ])
  }
  static func 👉(_ movingDown: Bool) -> Piece {
    return Piece(icon: "👉", movingDown: movingDown, validMoves: [GridPosition(column: 1, row: 1)])
  }
  static func 🍴(_ movingDown: Bool) -> Piece {
    return Piece(icon: "🍴", movingDown: movingDown, validMoves: [
      GridPosition(column: 1, row: Int.max),
      GridPosition(column: -1, row: Int.max),
      GridPosition(column: 1, row: -Int.max),
      GridPosition(column: -1, row: -Int.max),
    ])
  }
  
}

//extension Int {
//  public static var max: Int { get }
//}


///-------
///
///

//protocol ChessPiece {
//  var icon: String { get }
//  var movingDown: Bool { get }
//  var validMoves: [GridPosition] { get }
//}
//
//struct 🐴: ChessPiece {
//  var icon: String
//  var movingDown: Bool
//  
//  var validMoves: [GridPosition]
//  
//}
