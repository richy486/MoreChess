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
      ForEach(0...(appState.gameState.board.rows-1), id: \.self) { y in
        GridRow {
          ForEach(0...(appState.gameState.board.columns-1), id: \.self) { x in
            let piece = appState.gameState.board[x, y]
            let isTarget = appState.positioningState.targetGrid?.column == x
                           && appState.positioningState.targetGrid?.row == y
            let gridPosition = GridCoordinate(column: x, row: y)
            let isSelected = appState.positioningState.selectedGridPosition?.column == x
                             && appState.positioningState.selectedGridPosition?.row == y
            let offset = appState.positioningState.pieceOffset(gridPosition)
            Group {
              if let piece {
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
                                  from: GridCoordinate(column: x, row: y))
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
                                   rowIndex: y,
                                   columnIndex: x,
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
