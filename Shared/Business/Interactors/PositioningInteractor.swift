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
  let gameRepository = GameRepository()
  
  func update(dragOffset: CGSize, from fromGridPosition: GridCoordinate) {
    
    // Is the current player local?
    guard appState.gameState.currentTurn.local else {
      return
    }
    
    // Is there a piece at this grid position?
    guard let piece = appState.gameState.board[fromGridPosition.row][fromGridPosition.column] else {
      return
    }
    // Is this the right player's piece?
    guard piece.player == appState.gameState.currentTurn else {
      return
    }
    
    appState.positioningState.dragOffset = dragOffset
    
    // Set the starting position
    if appState.positioningState.selectedGridPosition == nil {
      appState.positioningState.selectedGridPosition = fromGridPosition
    }
    
    let gridOffset = gridOffsetFrom(offset: dragOffset)
    
    appState.positioningState.targetGrid = 
      MoveValidator.targetGridFrom(dragIndex: fromGridPosition,
                                   gridOffset: gridOffset,
                                   board: appState.gameState.board,
                                   columnCount: appState.gameState.columnCount,
                                   rowCount: appState.gameState.rowCount)
  }
  
  func endDrag() {
    // Must have a starting position to end the move
    guard let selectedGridPosition = appState.positioningState.selectedGridPosition else {
      return // Do nothing
    }
    
    // Move the piece if there is a valid target and swap turn.
    if let targetGrid = appState.positioningState.targetGrid {
      movePiece(from: selectedGridPosition, to: targetGrid)
      appState.gameState.currentTurn = appState.gameState.currentOpponent
      // TODO: Check for win state
      
      // Fetch the next board
      // TODO: Make this work for two non-local players.
      if appState.gameState.currentTurn.local == false {
        Task {
          appState.gameState.board = await gameRepository
            .fetchBoard(currentPlayer: appState.gameState.currentTurn,
                        opponent: appState.gameState.currentOpponent,
                        currentBoard: appState.gameState.board,
                        columnCount: appState.gameState.columnCount,
                        rowCount: appState.gameState.rowCount)
          // Switch back
          appState.gameState.currentTurn = appState.gameState.currentOpponent
          // TODO: Check for win state
        }
      }
    }
    
    // Reset positioning values.
    appState.positioningState.selectedGridPosition = nil
    appState.positioningState.targetGrid = nil
  }
  
  // MARK: Private functions
  
  private func gridOffsetFrom(offset: CGSize) -> GridCoordinate {
    let x = Int(floor((offset.width + appState.layoutState.elementDiameter/2) / appState.layoutState.elementDiameter))
    let y = Int(floor((offset.height + appState.layoutState.elementDiameter/2) / appState.layoutState.elementDiameter))
    return GridCoordinate(column: x, row: y)
  }
  
  private func movePiece(from: GridCoordinate, to: GridCoordinate) {
    let piece = appState.gameState.board[from.row][from.column]
    appState.gameState.board[to.row][to.column] = piece
    appState.gameState.board[from.row][from.column] = nil
  }
}
