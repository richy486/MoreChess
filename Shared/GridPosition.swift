//
//  GridPosition.swift
//  MoreChess
//
//  Created by Richard Adem on 1/4/24.
//

import Foundation

//typealias GridPosition = (column: Int, row: Int)

struct GridPosition: Hashable {
  let column: Int
  let row: Int
  
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
