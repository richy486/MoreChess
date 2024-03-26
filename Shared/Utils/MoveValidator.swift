//
//  MoveValidator.swift
//  MoreChess (iOS)
//
//  Created by Richard Adem on 3/23/24.
//

import Foundation

struct MoveValidator {
  static func targetGridFrom(dragIndex: GridCoordinate?, gridOffset: GridCoordinate, board: Board, columnCount: Int, rowCount: Int) -> GridCoordinate? {
    guard let dragIndex, let currentPlayerPiece = board[dragIndex.row][dragIndex.column] else {
      return nil
    }
    
    let targetPosition = GridCoordinate(column: dragIndex.column + gridOffset.column, row: dragIndex.row + gridOffset.row)
    
    // Inside board
    guard targetPosition.column >= 0 && targetPosition.column < columnCount &&
            targetPosition.row >= 0 && targetPosition.row < rowCount else {
      return nil
    }
    
    // Validate position
    guard currentPlayerPiece.validMoves.first(where: { validMove in
      // Check for not `moveDown`.
      // TODO: Bug where 👉 piece is rotated when board is flipped.
      let validMoveRow = currentPlayerPiece.player.movingDown ? validMove.row : validMove.row * -1
      let validMoveColumn = currentPlayerPiece.player.movingDown ? validMove.column : validMove.column * -1
      
      // If there are two `Int.max` their absolute values must be equal.
      if abs(validMoveRow) == Int.max && abs(validMoveColumn) == Int.max
          && abs(gridOffset.row) != abs(gridOffset.column) {
        return false
      }
      
      // Is there a board position?
      guard (gridOffset.column == validMoveColumn || (gridOffset.column > 0 && validMoveColumn == Int.max) || (gridOffset.column < 0 && validMoveColumn == -Int.max))
              && (gridOffset.row == validMoveRow || (gridOffset.row > 0 && validMoveRow == Int.max) || (gridOffset.row < 0 && validMoveRow == -Int.max) ) else {
        return false
      }
      return true
    }) != nil else {
      return nil
    }
    
    // If there is a piece in the target position, it has to be the opponent.
    if let targetPiece = board[targetPosition.row][targetPosition.column] {
      guard targetPiece.player != currentPlayerPiece.player else {
        return nil
      }
    }

    return targetPosition
  }
}
