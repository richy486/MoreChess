//
//  GameRepository.swift
//  MoreChess (iOS)
//
//  Created by Richard Adem on 3/23/24.
//

import Foundation

// TODO: "Facade" this with a protocol so data can be mocked.
protocol GameRepository {
  func fetchBoard(currentPlayer: Player,
                  opponent: Player,
                  currentBoard board: Board2<GamePiece?>,
                  columnCount: Int,
                  rowCount: Int) async -> Board2<GamePiece?>
}


 
