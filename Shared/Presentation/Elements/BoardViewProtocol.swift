//
//  BoardViewProtocol.swift
//  MoreChess
//
//  Created by Richard Adem on 25/01/2025.
//

import SwiftUI

protocol BoardViewProtocol {}
extension BoardViewProtocol {
  func background(isTarget: Bool, rowIndex: Int, columnIndex: Int, rowCount: Int) -> some View {
    let index = rowIndex * rowCount + columnIndex
    let color: Color = switch (isTarget, (index % 2 == 0)) {
    case (true, _):
        PresentationConstants.GameColor.targetColor
    default:
      .clear
    }
    return ZStack {

      // Figure out the background color by checking if the row index is even, and flip that is the
      // column index is even.
      let rowIndexEven = rowIndex % 2 == 0
      let showOddBoardColor = columnIndex % 2 == 0 ? !rowIndexEven : rowIndexEven
      Rectangle().fill(showOddBoardColor
                       ? PresentationConstants.GameColor.oddBoardColor
                       : PresentationConstants.GameColor.evenBoardColor)
      Rectangle().strokeBorder(color, lineWidth: 2)
    }
    .zIndex(Double(isTarget
                   ? PresentationConstants.ZIndex.target.rawValue
                   : PresentationConstants.ZIndex.normal.rawValue))
  }
}
