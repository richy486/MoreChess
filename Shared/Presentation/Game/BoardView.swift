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
    static let oddBoardColor = Color.gray
    static let evenBoardColor = Color.white
    static let boardOutline = Color.gray
  }
  
  private enum ZIndex: Int {
    case normal = 0
    case target = 1
    case selected = 2
  }
  
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
                  .frame(width: appState.layoutState.elementDiameter,
                         height: appState.layoutState.elementDiameter)
                  .background(isTarget ? Constants.targetColor : piece.player.color)
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
                  .zIndex(Double(isSelected ? ZIndex.selected.rawValue : ZIndex.normal.rawValue))
              } else {
                Color.clear
                  .frame(width: appState.layoutState.elementDiameter,
                         height: appState.layoutState.elementDiameter)
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
    .border(Constants.boardOutline, width: 1)
  } // body
  
  func background(isTarget: Bool, rowIndex: Int, columnIndex: Int, rowCount: Int) -> some View {
    let index = rowIndex * rowCount + columnIndex
    let color: Color = switch (isTarget, (index % 2 == 0)) {
    case (true, _):
      Constants.targetColor
    default:
      .clear
    }
    return ZStack {
      Rectangle().fill((index % 2 == 0) ? Constants.oddBoardColor : Constants.evenBoardColor)
      Rectangle().strokeBorder(color, lineWidth: 2)
    }
    .zIndex(Double(isTarget ? ZIndex.target.rawValue : ZIndex.normal.rawValue))
  }
}

#Preview {
  let appState = AppState()
  return BoardView(positioningInteractor: PositioningInteractor(appState: appState))
    .environment(appState)
}
