//
//  PieceView.swift
//  MoreChess
//
//  Created by Richard Adem on 3/16/24.
//

import SwiftUI

struct PieceView: View {
  let piece: Piece
  var body: some View {
    Text(piece.icon)
      .font(.system(size: 999))
      .minimumScaleFactor(0.01)
  }
}

#Preview {
  PieceView(piece: Pieces.🐴(false))
}
