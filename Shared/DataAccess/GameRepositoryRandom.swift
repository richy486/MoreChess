//
//  GameRepositoryRandom.swift
//  MoreChess
//
//  Created by Richard Adem on 24/02/2025.
//


class GameRepositoryRandom: GameRepository {

  func fetchBoard(currentPlayer: Player,
                  opponent: Player,
                  currentBoard board: Board2<GamePiece?>,
                  columnCount: Int,
                  rowCount: Int) async -> Board2<GamePiece?> {
    // Debug sleep
//    try? await Task.sleep(nanoseconds: UInt64(2 * Double(NSEC_PER_SEC)))
    
    // Get all current piece positions
    let allPositions: [GridCoordinate] = board.reduce([], { partialResult, value in
      guard let piece = value.2 else {
        return partialResult
      }
      guard piece.player == currentPlayer else {
        return partialResult
      }
      return partialResult + [GridCoordinate(column: value.0, row: value.1)]
    })

    // Get a random piece
    guard let randomPiecePosition = allPositions.randomElement() else {
      fatalError("Can't get random piece positions")
    }
    guard let piece = board[randomPiecePosition.column, randomPiecePosition.row] else {
      fatalError("Can't get random piece")
    }
    
    // Get a random valid move
    guard let move = piece.pieceBase.validMoves.randomElement() else {
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
    updatedBoard[targetPosition.column, targetPosition.row] = piece
    updatedBoard[randomPiecePosition.column, randomPiecePosition.row] = nil

    return updatedBoard
  }
}