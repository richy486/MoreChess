//
//  GridCoordinate.swift
//  MoreChess
//
//  Created by Richard Adem on 1/4/24.
//

import Foundation

struct GridCoordinate: Hashable {
  let column: Int
  let row: Int

  // true: must land on an opponent e.g. Pawn attack.
  // false: must NOT land on an opponent e.g. Pawn forward.
  // nil: opponent or empty square e.g. most other regular pieces.
  let attacking: Bool?

  init(column: Int, row: Int, attacking: Bool? = nil) {
    self.column = column
    self.row = row
    self.attacking = attacking
  }

  func draw() -> String {
    let maxSize = 10
    var result: [String] = []
    for y in min(0, row)...max(0, min(row, maxSize)) {
      var rowString: String = ""
      for x in min(0, column)...max(0, min(column, maxSize)) {
        if x == 0 && y == 0 {
          rowString.append("*")
        } else if (x == column || x == maxSize) && (y == row || y == maxSize) {
          rowString.append("$")
        } else {
          rowString.append("_")
        }
      }
      result.append(rowString)
    }
    return result.joined(separator: "\n")
  }
}


// TODO: Equal absolute values of column and row
// TODO: Special attack moves
// TODO: Rotatable, horizontal, vertical, diagonal
