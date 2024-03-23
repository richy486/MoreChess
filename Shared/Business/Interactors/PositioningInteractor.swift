//
//  PositioningInteractor.swift
//  MoreChess (iOS)
//
//  Created by Richard Adem on 3/23/24.
//

import Foundation

// TODO: "Facade" this with a protocol so data can be mocked.

struct PositioningInteractor {
  let appState: AppState
  
  func update(dragOffset: CGSize, from fromGridPosition: GridCoordinate) {
    
    appState.positioningState.dragOffset = dragOffset
    
    // Set the starting position
    if appState.positioningState.selectedGridPosition == nil {
      appState.positioningState.selectedGridPosition = fromGridPosition
    }
    
    let gridOffset = gridOffsetFrom(offset: dragOffset)
    
    appState.positioningState.targetGrid = targetGridFrom(dragIndex: fromGridPosition,
                                                          gridOffset: gridOffset)
  }
  
  func endDrag() {
    // Must have a starting position to end the move
    guard let selectedGridPosition = appState.positioningState.selectedGridPosition else {
      fatalError("Selected and target grid position must not be nil when drag ending")
    }
    
    // Move the piece if there is a valid target.
    if let targetGrid = appState.positioningState.targetGrid {
      // Target grid is only required for a valid move.
      movePiece(from: selectedGridPosition, to: targetGrid)
    }
    appState.positioningState.selectedGridPosition = nil
    appState.positioningState.targetGrid = nil
    
    // TODO: Swap turn
    
  }
  
  // MARK: Private functions
  
  private func gridOffsetFrom(offset: CGSize) -> GridCoordinate {
    let x = Int(floor((offset.width + appState.layoutState.elementDiameter/2) / appState.layoutState.elementDiameter))
    let y = Int(floor((offset.height + appState.layoutState.elementDiameter/2) / appState.layoutState.elementDiameter))
    return GridCoordinate(column: x, row: y)
  }
  
  private func targetGridFrom(dragIndex: GridCoordinate?, gridOffset: GridCoordinate) -> GridCoordinate? {
    guard let dragIndex, let piece = appState.gameState.board[dragIndex.row][dragIndex.column] else {
      return nil
    }
    
    let targetPosition = GridCoordinate(column: dragIndex.column + gridOffset.column, row: dragIndex.row + gridOffset.row)
    
    // Inside board
    guard targetPosition.column >= 0 && targetPosition.column < appState.gameState.columnCount &&
            targetPosition.row >= 0 && targetPosition.row < appState.gameState.rowCount else {
      return nil
    }
    
    // Validate position
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
        return targetPosition
      }
    }

    return nil
  }
  
  private func movePiece(from: GridCoordinate, to: GridCoordinate) {
    let piece = appState.gameState.board[from.row][from.column]
    appState.gameState.board[to.row][to.column] = piece
    appState.gameState.board[from.row][from.column] = nil
  }
}
