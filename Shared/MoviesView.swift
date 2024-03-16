//
//  MoviesView.swift
//  MoreChess
//
//  Created by Richard Adem on 3/16/24.
//

import SwiftUI

struct MoviesView: View {
  
  let pieceList: [Piece]
  
  var body: some View {
    ScrollView {
      ForEach(pieceList, id: \.icon) { piece in
        VStack {
          Text(piece.icon)
//          Text(piece.drawMoves())
//                      ForEach(piece.validMoves, id: \.self) { move in
//                        Text("move \(move.draw())")
//                      }
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
