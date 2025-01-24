//
//  GameView.swift
//  MoreChess (iOS)
//
//  Created by Richard Adem on 3/24/24.
//

import SwiftUI

struct GameView: View {
  
  @Environment(AppState.self) private var appState  

  var body: some View {
    VStack {
      
      playConditionView()
      
      Spacer()
      
      BoardView()

      Spacer()
      
      // Debug
      Text("offset: \(appState.positioningState.dragOffset.width) \(appState.positioningState.dragOffset.height)")
      if let selectedGridPosition = appState.positioningState.selectedGridPosition, let piece = appState.gameState.board[selectedGridPosition.row][selectedGridPosition.column] {
        Text("selected: col: \(selectedGridPosition.column) row: \(selectedGridPosition.row) \(piece.pieceBase.icon)")
      } else {
        Text("selected:")
      }
      if let targetGrid = appState.positioningState.targetGrid {
        Text("target: \(targetGrid.column) \(targetGrid.row)")
      } else {
        Text("target:")
      }
      Text("Row count: \(appState.gameState.rowCount), Column count: \(appState.gameState.columnCount)")
      
    } // VStack
    .style()
  } // body
  
  @ViewBuilder func playConditionView() -> some View {
    switch appState.gameState.playCondition {
    case .playing:
      VStack {
        Text("Current turn: \(appState.gameState.currentTurn.name)")
        HStack {
          Text("Playing state: ")
          if appState.gameState.currentTurn.local {
            Text("📱")
          } else {
            WaitingView()
          }
        }
      }
    case .win(let player):
      Text("Player \(player.name) Won!")
    case .tie:
      Text("Tie!")
    }
  }
}

#Preview {
  let appState = AppState()
  return GameView()
    .environment(appState)
}
