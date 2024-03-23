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
    static let movingDownColor = Color(hue: 0.15, saturation: 0.75, brightness: 1)
    static let movingUpColor = Color(hue: 0.55, saturation: 0.75, brightness: 1)
  }
  
  var body: some View {
    Grid(horizontalSpacing: 0, verticalSpacing: 0) {
      ForEach(Array(appState.gameState.board.enumerated()), id: \.offset) { rowIndex, row in
        GridRow {
          ForEach(Array(row.enumerated()), id:\.offset) { columnIndex, item in
            let isTarget = appState.positioningState.targetGrid?.column == columnIndex
              && appState.positioningState.targetGrid?.row == rowIndex
            Group {
              if let item {
                let offset = appState.positioningState.pieceOffset(GridCoordinate(column: columnIndex, row: rowIndex))
                PieceView(piece: item)
                  .frame(width: appState.layoutState.elementDiameter, 
                         height: appState.layoutState.elementDiameter)
                  .background(backgroundColor(isTarget: isTarget, movingDown: item.movingDown))
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
            .zIndex(isTarget ? 0 : -1) // TODO: this puts the dragged icon behind other icons sometimes
          }
        }
      }
    } // Grid
  } // body

  private func backgroundColor(isTarget: Bool, movingDown: Bool) -> Color {
    if isTarget {
      return Color.red
    } else if movingDown {
      return Constants.movingDownColor
    } else {
      return Constants.movingUpColor
    }
  }
}

#Preview {
  let appState = AppState()
  return BoardView(positioningInteractor: PositioningInteractor(appState: appState))
    .environment(appState)
}
