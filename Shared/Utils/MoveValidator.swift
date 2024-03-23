//
//  MoveValidator.swift
//  MoreChess (iOS)
//
//  Created by Richard Adem on 3/23/24.
//

import Foundation

struct MoveValidator {
  static func targetGridFrom(dragIndex: GridCoordinate?, gridOffset: GridCoordinate, board: Board, columnCount: Int, rowCount: Int) -> GridCoordinate? {
    guard let dragIndex, let piece = board[dragIndex.row][dragIndex.column] else {
      return nil
    }
    
    let targetPosition = GridCoordinate(column: dragIndex.column + gridOffset.column, row: dragIndex.row + gridOffset.row)
    
    // Inside board
    guard targetPosition.column >= 0 && targetPosition.column < columnCount &&
            targetPosition.row >= 0 && targetPosition.row < rowCount else {
      return nil
    }
    
    // Validate position
    // TODO: Maybe replace this with a filter so we can use a guard.
    for validMove in piece.validMoves {
      // Check for not `moveDown`.
      let validMoveRow = piece.player.movingDown ? validMove.row : validMove.row * -1
      let validMoveColumn = piece.player.movingDown ? validMove.column : validMove.column * -1
      
      // If there are two `Int.max` their absolute values must be equal.
      if abs(validMoveRow) == Int.max && abs(validMoveColumn) == Int.max
          && abs(gridOffset.row) != abs(gridOffset.column) {
        continue
      }
      
      if (gridOffset.column == validMoveColumn || (gridOffset.column > 0 && validMoveColumn == Int.max) || (gridOffset.column < 0 && validMoveColumn == -Int.max))
          && (gridOffset.row == validMoveRow || (gridOffset.row > 0 && validMoveRow == Int.max) || (gridOffset.row < 0 && validMoveRow == -Int.max) ) {
        
        // TODO: Is target empty space or opponent's space?
        
        // Found a valid target
        return targetPosition
      }
    }

    return nil
  }
}
