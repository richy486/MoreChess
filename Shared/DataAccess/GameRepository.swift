//
//  GameRepository.swift
//  MoreChess (iOS)
//
//  Created by Richard Adem on 3/23/24.
//

import Foundation

// TODO: "Facade" this with a protocol so data can be mocked.

struct GameRepository {
  func fetchBoard(currentPlayer: Player, 
                  opponent: Player,
                  currentBoard board: Board,
                  columnCount: Int,
                  rowCount: Int) async -> Board {
    // Debug sleep
    try? await Task.sleep(nanoseconds: UInt64(2 * Double(NSEC_PER_SEC)))
    
    // Get all current piece positions
    let allPositions: [GridCoordinate] = board.enumerated().reduce([], { partialResult, value in
      let rowIndex = value.offset
      let row = value.element
      let rowPositions: [GridCoordinate] = Array(row.enumerated()).compactMap { (columnIndex, piece) in
        guard let piece else {
          return nil
        }
        guard piece.player == currentPlayer else {
          return nil
        }
        return GridCoordinate(column: columnIndex, row: rowIndex)
      }
      return partialResult + rowPositions
    })
    
    // Get a random piece
    guard let randomPiecePosition = allPositions.randomElement() else {
      fatalError("Can't get random piece positions")
    }
    guard let piece = board[randomPiecePosition.row][randomPiecePosition.column] else {
      fatalError("Can't get random piece")
    }
    
    // Get a random valid move
    guard let move = piece.validMoves.randomElement() else {
      fatalError("Can't get random move")
    }
    
    // If move contains infinity pick a random number
    let clampedColumn: Int
    if move.column == Int.max {
      clampedColumn = (0..<columnCount).randomElement() ?? 0
    } else if move.column == -Int.max {
      clampedColumn = ((0..<columnCount).randomElement() ?? 0) * -1
    } else {
      clampedColumn = move.column
    }
    let clampedRow: Int
    if move.row == Int.max {
      clampedRow = (0..<rowCount).randomElement() ?? 0
    } else if move.row == -Int.max {
      clampedRow = ((0..<rowCount).randomElement() ?? 0) * -1
    } else {
      clampedRow = move.row
    }
    let clampedMove = GridCoordinate(column: clampedColumn, row: clampedRow)
    
    // Get target position
    guard let targetPosition = MoveValidator
      .validTargetPosition(startingCoordinate: randomPiecePosition,
                           toGridOffset: clampedMove,
                           board: board,
                           columnCount: columnCount,
                           rowCount: rowCount) else {
      // Invalid move
      // TODO: Must return a valid move, try again? filter valid targets?
      print("Generated invalid move")
      return board
    }
    
    
    // Update board
    var updatedBoard = board
    updatedBoard[targetPosition.row][targetPosition.column] = piece
    updatedBoard[randomPiecePosition.row][randomPiecePosition.column] = nil
        
    return updatedBoard
  }
}
 
