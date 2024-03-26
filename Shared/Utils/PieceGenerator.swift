//
//  PieceGenerator.swift
//  MoreChess
//
//  Created by Richard Adem on 1/30/24.
//

import Foundation

struct PieceGenerator {
  static func randomPiece(forPlayer player: Player, horizontalSize: Int, verticalSize: Int) -> Piece {
    let validMoves: [GridCoordinate] = [
      GridCoordinate(column: 0, row: Int.random(in: 1...3)),
    ]
    let emoji = Character(UnicodeScalar(Array(0x1F300...0x1F3F0).randomElement()!)!)
    return Piece(icon: emoji, player: player, validMoves: validMoves)
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
