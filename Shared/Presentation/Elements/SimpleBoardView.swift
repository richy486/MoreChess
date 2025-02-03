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
  let board: Board2<GamePiece?>

  init(board: Board2<GamePiece?>) {
    self.board = board
  }

  var body: some View {
    Grid(horizontalSpacing: 0, verticalSpacing: 0) {
      ForEach(0...(board.rows-1), id: \.self) { y in
        GridRow {
          ForEach(0...(board.columns-1), id: \.self) { x in
            Color.clear
              .frame(width: PresentationConstants.Layout.elementDiameter,
                     height: PresentationConstants.Layout.elementDiameter)
              .background(
                background(isTarget: false,
                           rowIndex: y,
                           columnIndex: x,
                           rowCount: board.rows)
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
