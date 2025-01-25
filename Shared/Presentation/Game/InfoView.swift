//
//  InfoView.swift
//  MoreChess (iOS)
//
//  Created by Richard Adem on 25/01/2025.
//

import SwiftUI

struct InfoView: View {
  @Environment(AppState.self) private var appState
  var body: some View {
    ScrollView {
      VStack {
        let sorted = appState.gameState.uniquePieces.sorted { $0.key > $1.key }
        ForEach(sorted, id: \.key) { key, piece in
          Text(String(piece.pieceBase.icon))          
          moves(validMoves: piece.pieceBase.validMoves)
        }
      }
      .frame(maxWidth: .infinity, alignment: .center)
    }
  }

  // Transform infinities to 1 for board representation.
  private func infinityToOne(_ int: Int) -> Int {
    if int == Int.max {
      return 1
    } else if int == -Int.max {
      return -1
    } else {
      return int
    }
  }

  @ViewBuilder private func moves(validMoves: [GridCoordinate]) -> some View {

    // Get the list of row positions plus zero to get the min / max of the board from initial
    // position of zero.
    let rows = validMoves.map { infinityToOne($0.row) } + [0]
    let columns = validMoves.map { infinityToOne($0.column) } + [0]

    // Get the min max.
    let minRow = rows.min() ?? 0
    let maxRow = rows.max() ?? 0
    let minColumn = columns.min() ?? 0
    let maxColumn = columns.max() ?? 0

    // Make the board width and height plus 1 for the starting point, expanding from the starting
    // point out by the distance of the min / max.
    let width = abs(minColumn - maxColumn) + 1
    let height = abs(minRow - maxRow) + 1
    if width <= 0 && height <= 0 {
      Text("can make board with \(width) x \(height)")
    } else {
      let board: Board = Array(repeating: Array(repeating: nil, count: width), count: height)

      VStack {
        Text("\(minColumn) x \(maxColumn) -> \(width)")
        Text("\(minRow) x \(maxRow) -> \(height)")
        SimpleBoardView(board: board)
      }
    }
  }
}

#Preview {
  InfoView()
    .environment(AppState())
}
