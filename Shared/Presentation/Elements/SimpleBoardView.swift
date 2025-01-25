//
//  SimpleBoardView.swift
//  MoreChess (iOS)
//
//  Created by Richard Adem on 25/01/2025.
//

import SwiftUI

// TODO: Add starting position and valid moves.
// TODO: Can this be combined with `BoardView` to avoid repeated code?

/// Like `BoardView` but with no interaction, just to display something.
struct SimpleBoardView: View, BoardViewProtocol {
  let board: Board
  var body: some View {
    Grid(horizontalSpacing: 0, verticalSpacing: 0) {
      ForEach(Array(board.enumerated()), id: \.offset) { rowIndex, row in
        GridRow {
          ForEach(Array(row.enumerated()), id:\.offset) { columnIndex, piece in
            Color.clear
              .frame(width: PresentationConstants.Layout.elementDiameter,
                     height: PresentationConstants.Layout.elementDiameter)
              .background(
                background(isTarget: false,
                           rowIndex: rowIndex,
                           columnIndex: columnIndex,
                           rowCount: board.count)
              )
          }
        }
      }
    }
  }
}

#Preview {
  SimpleBoardView(board: BoardFactory.fiveByFive.makeBoard(players: [
    Players.one(local: true),
    Players.two(local: false)
  ]))
}
