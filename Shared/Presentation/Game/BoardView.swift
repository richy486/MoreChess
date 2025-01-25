//
//  BoardView.swift
//  MoreChess (iOS)
//
//  Created by Richard Adem on 3/23/24.
//

import SwiftUI

struct BoardView: View, BoardViewProtocol {
  @Environment(AppState.self) private var appState
  @Environment(PositioningInteractor.self) private var positioningInteractor

  var body: some View {
    Grid(horizontalSpacing: 0, verticalSpacing: 0) {
      ForEach(Array(appState.gameState.board.enumerated()), id: \.offset) { rowIndex, row in
        GridRow {
          ForEach(Array(row.enumerated()), id:\.offset) { columnIndex, piece in
            let isTarget = appState.positioningState.targetGrid?.column == columnIndex
              && appState.positioningState.targetGrid?.row == rowIndex
            let gridPosition = GridCoordinate(column: columnIndex, row: rowIndex)
            let isSelected = appState.positioningState.selectedGridPosition?.column == columnIndex
              && appState.positioningState.selectedGridPosition?.row == rowIndex
            Group {
              if let piece {
                let offset = appState.positioningState.pieceOffset(gridPosition)
                PieceView(piece: piece)
                  .accessibility(label: Text("\(piece.description) piece"))
                  .frame(width: PresentationConstants.Layout.elementDiameter,
                         height: PresentationConstants.Layout.elementDiameter)
                  .background(isTarget ? PresentationConstants.GameColor.targetColor : piece.player.color)
                  .offset(x: offset.width * (isRTL ? -1 : 1), y: offset.height)
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
                  .zIndex(Double(isSelected
                                 ? PresentationConstants.ZIndex.selected.rawValue
                                 : PresentationConstants.ZIndex.normal.rawValue))
              } else {
                Color.clear
                  .frame(width: PresentationConstants.Layout.elementDiameter,
                         height: PresentationConstants.Layout.elementDiameter)
              }
            } // Group
            .background(background(isTarget: isTarget, 
                                   rowIndex: rowIndex,
                                   columnIndex: columnIndex,
                                   rowCount: appState.gameState.rowCount))
          }
        }
      }
    } // Grid
    .border(PresentationConstants.GameColor.boardOutline, width: 1)
  } // body
}

#Preview {
  let appState = AppState()
  let positioningInteractor = PositioningInteractor(appState: appState)
  return BoardView()
    .environment(appState)
    .environment(positioningInteractor)
}
