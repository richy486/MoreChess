//
//  PieceView.swift
//  MoreChess
//
//  Created by Richard Adem on 3/16/24.
//

import SwiftUI

struct PieceView: View {
  let piece: GamePiece
  var body: some View {
    Text(String(piece.pieceBase.icon))
      .font(.system(size: 999))
      .minimumScaleFactor(0.01)
  }
}

#Preview {
  PieceView(piece: GamePiece(pieceBase: 🐴, player: Players.one(local: true)))
}
