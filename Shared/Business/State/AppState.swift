//
//  AppState.swift
//  MoreChess (iOS)
//
//  Created by Richard Adem on 3/23/24.
//

import Foundation

@Observable class AppState {
  var gameState = GameState()
  var positioningState = PositioningState()
  var layoutState = LayoutState()
}
