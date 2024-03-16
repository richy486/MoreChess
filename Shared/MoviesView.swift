//
//  MoviesView.swift
//  MoreChess
//
//  Created by Richard Adem on 3/16/24.
//

import SwiftUI

struct MoviesView: View {
  @Environment(GameViewModel.self) private var gameViewModel
  
  let pieceList: [Piece]
  
  private enum Constants {
    static let elementDiameter: CGFloat = 50
    static let movingDownColor = Color(hue: 0.15, saturation: 0.75, brightness: 1)
    static let movingUpColor = Color(hue: 0.55, saturation: 0.75, brightness: 1)
    
  }
  
  var body: some View {
    ScrollView {
      ForEach(pieceList, id: \.icon) { piece in
        VStack {
          Grid(horizontalSpacing: 0, verticalSpacing: 0) {
            ForEach(0...2, id: \.self) { rowIndex in
              GridRow {
                ForEach(0...2, id: \.self) { columnIndex in
//                  let targetGrid = gameViewModel
//                    .targetGridFrom(dragIndex: GridPosition(column: 1, row: 1),
//                                    gridOffset: GridPosition(column: columnIndex - 1, row: rowIndex - 1))
//                  
                  Group {
                    if rowIndex == 1 && columnIndex == 1 {
                      PieceView(piece: piece)
                        .frame(width: Constants.elementDiameter, height: Constants.elementDiameter)
                    } else {
                      Color.clear
                        .frame(width: Constants.elementDiameter, height: Constants.elementDiameter)
                    }
                  } // Group
                  .background(
                    Rectangle().stroke(.gray, lineWidth: 1)
                  )
                }
              }
            }
          }
        }
      }
    }
  }
}

#Preview {
  MoviesView(pieceList: [
    Pieces.🐴(false),
    Pieces.🥷(false),
    Pieces.🤴(false),
    Pieces.👸(false),
    //PieceGenerator.randomPiece(movingDown: false, horizontalSize: 5, verticalSize: 5)
  ])
}
