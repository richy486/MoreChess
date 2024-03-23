//
//  BoardView.swift
//  MoreChess (iOS)
//
//  Created by Richard Adem on 3/23/24.
//

import SwiftUI

struct BoardView: View {
  @Environment(AppState.self) private var appState
  
  let positioningInteractor: PositioningInteractor
  
  private enum Constants {
    static let targetColor = Color.red
  }
  
  var body: some View {
    Grid(horizontalSpacing: 0, verticalSpacing: 0) {
      ForEach(Array(appState.gameState.board.enumerated()), id: \.offset) { rowIndex, row in
        GridRow {
          ForEach(Array(row.enumerated()), id:\.offset) { columnIndex, piece in
            let isTarget = appState.positioningState.targetGrid?.column == columnIndex
              && appState.positioningState.targetGrid?.row == rowIndex
            let gridPosition = GridCoordinate(column: columnIndex, row: rowIndex)
            Group {
              if let piece {
                let offset = appState.positioningState.pieceOffset(gridPosition)
                PieceView(piece: piece)
                  .frame(width: appState.layoutState.elementDiameter, 
                         height: appState.layoutState.elementDiameter)
                  .background(isTarget ? Constants.targetColor : piece.player.color)
                  .offset(x: offset.width, y: offset.height)
                  .gesture(
                    DragGesture()
                      .onChanged { gesture in
                        positioningInteractor
                          .update(dragOffset: gesture.translation,
                                  from: GridCoordinate(column: columnIndex, row: rowIndex))
                      }
                      .onEnded { _ in
                        positioningInteractor.endDrag()
                      }
                  )
              } else {
                Color.clear
                  .frame(width: appState.layoutState.elementDiameter,
                         height: appState.layoutState.elementDiameter)
              }
            } // Group
            .background(
              Rectangle()
                .stroke(isTarget ? .red : .green,
                        lineWidth: 1)
            )
            // TODO: this puts the dragged icon behind other icons sometimes.
            .zIndex(isTarget ? 0 : -1)
          }
        }
      }
    } // Grid
  } // body
}

#Preview {
  let appState = AppState()
  return BoardView(positioningInteractor: PositioningInteractor(appState: appState))
    .environment(appState)
}
