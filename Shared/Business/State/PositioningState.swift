//
//  PositioningState.swift
//  MoreChess (iOS)
//
//  Created by Richard Adem on 3/23/24.
//

import Foundation

// This is the state when a (usually human) player is moving in their turn, trying positions before
// dropping a piece.
struct PositioningState {
  
  // Dragging offset in view display position.
  var dragOffset = CGSize.zero
  

  // TODO: Combine these into (target: GridCoordinate, valid: Bool) ?
  // Starting grid position of a move
  var selectedGridPosition: GridCoordinate? = nil
  // Valid grid position to drop piece
  var targetGrid: GridCoordinate? = nil
  
  // Offset for individual pieces, computed here, maybe this should be in the interactor?
  var pieceOffset: (GridCoordinate) -> CGSize {
    { gridPosition in
      
      // Do we have a starting position?
      guard let dragIndex = selectedGridPosition else {
        return .zero
      }
      
      // Is this being moved from the starting position?
      guard gridPosition.column == dragIndex.column && gridPosition.row == dragIndex.row else {
        return .zero
      }
      
      return dragOffset
    }
  }
}
