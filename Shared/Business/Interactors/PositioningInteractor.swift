//
//  PositioningInteractor.swift
//  MoreChess (iOS)
//
//  Created by Richard Adem on 3/23/24.
//

import Foundation

// TODO: "Facade" this with a protocol so data can be mocked.

@Observable class PositioningInteractor {
  let appState: AppState
  let gameRepository: GameRepository = GameRepositoryRandom()

  init(appState: AppState) {
    self.appState = appState
  }
  
  func update(dragOffset: CGSize, from fromGridPosition: GridCoordinate) {
    
    // Is the game playing
    guard appState.gameState.playCondition == .playing else {
      return
    }
    
    // Is the current player local?
    guard appState.gameState.currentTurn.local else {
      return
    }
    
    // Is there a piece at this grid position?
    guard let piece = appState.gameState.board[fromGridPosition.column, fromGridPosition.row] else {
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
    MoveValidator.validTargetPosition(startingCoordinate: fromGridPosition,
                                      toGridOffset: gridOffset,
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
      // Check for win state
      checkWinState()
            
      // Fetch the next board from computer player (non-local).
      // TODO: Make this work for two non-local players.
      if appState.gameState.playCondition == .playing 
          && appState.gameState.currentTurn.local == false {
        Task {
          let fetchedBoard = await gameRepository
            .fetchBoard(currentPlayer: appState.gameState.currentTurn,
                        opponent: appState.gameState.currentOpponent,
                        currentBoard: appState.gameState.board,
                        columnCount: appState.gameState.columnCount,
                        rowCount: appState.gameState.rowCount)

          await MainActor.run {
            appState.gameState.board = fetchedBoard
            // Switch back
            appState.gameState.currentTurn = appState.gameState.currentOpponent
            // Check for win state
            checkWinState()
          }

        }
      }
    }
    
    // Reset positioning values.
    appState.positioningState.selectedGridPosition = nil
    appState.positioningState.targetGrid = nil
  }

  func restartGame() {
    appState.gameState.setInitialGameState()
  }

  // MARK: Private functions
  
  private func gridOffsetFrom(offset: CGSize) -> GridCoordinate {
    let x = Int(floor((offset.width + PresentationConstants.Layout.elementDiameter/2) / PresentationConstants.Layout.elementDiameter)) * (isRTL ? -1 : 1)
    let y = Int(floor((offset.height + PresentationConstants.Layout.elementDiameter/2) / PresentationConstants.Layout.elementDiameter))
    return GridCoordinate(column: x, row: y)
  }
  
  private func movePiece(from: GridCoordinate, to: GridCoordinate) {
    let piece = appState.gameState.board[from.column, from.row]
    appState.gameState.board[to.column, to.row] = piece
    appState.gameState.board[from.column, from.row] = nil
  }
  
  private func checkWinState() {
    let originalPlayCondition = appState.gameState.playCondition
    let pieces = appState.gameState.board.grid.compactMap { $0 }

    // TODO: Check for checkmate.

    // No pieces left
    let uniquePlayers = Set(pieces.map { $0.player })
    switch uniquePlayers.count {
    case 0:
      // How could this happen?
      appState.gameState.playCondition = .tie
    case 1:
      appState.gameState.playCondition = .win(player: uniquePlayers.first!)
    default:
      break
    }

    // If Game over, and this is the first time in this game it happened.
    if appState.gameState.playCondition != .playing && originalPlayCondition == .playing {
      // Store the game in `historyState`
      let gameHistory = appState.gameState.generateAGameHistory()
      appState.historyState.history.append(gameHistory)
    }
  }
}
