//
//  BoardViewModel.swift
//  MoreChess
//
//  Created by Richard Adem on 1/15/24.
//

import Foundation

@Observable class GameViewModel {
  // This data structure is (row, column), most of the other code is (column, row) because that is (x, y).
  var board: [[Piece?]] = [[]]

  var rowCount: Int { return board.count }
  var columnCount: Int {
    return board.reduce(999, { partialResult, row in
      return min(partialResult, row.count)
    })
  }
  
  func targetGridFrom(dragIndex: GridPosition?, gridOffset: GridPosition) -> GridPosition? {
    guard let dragIndex, let piece = board[dragIndex.row][dragIndex.column] else {
      return nil
    }
    
    let targetPosition = GridPosition(column: dragIndex.column + gridOffset.column, row: dragIndex.row + gridOffset.row)
    
    // Inside board
    guard targetPosition.column >= 0 && targetPosition.column < columnCount &&
            targetPosition.row >= 0 && targetPosition.row < rowCount else {
      return nil
    }
    
    // Validate position
    for validMove in piece.validMoves {
      // Check for not `moveDown`.
      let validMoveRow = piece.movingDown ? validMove.row : validMove.row * -1
      let validMoveColumn = piece.movingDown ? validMove.column : validMove.column * -1
      
      // If there are two `Int.max` their absolute values must be equal.
      if abs(validMoveRow) == Int.max && abs(validMoveColumn) == Int.max
          && abs(gridOffset.row) != abs(gridOffset.column) {
        continue
      }
      
      if (gridOffset.column == validMoveColumn || (gridOffset.column > 0 && validMoveColumn == Int.max) || (gridOffset.column < 0 && validMoveColumn == -Int.max))
          && (gridOffset.row == validMoveRow || (gridOffset.row > 0 && validMoveRow == Int.max) || (gridOffset.row < 0 && validMoveRow == -Int.max) ) {
        return targetPosition
      }
    }
    
    
    return nil
  }
}
