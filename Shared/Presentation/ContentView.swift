//
//  ContentView.swift
//  Shared
//
//  Created by Richard Adem on 10/10/23.
//

import SwiftUI

struct ContentView: View {
  @State var appState = AppState()
  
  var body: some View {
    VStack {
      
      Text("Current turn: \(appState.gameState.currentTurn.name)")
      Text("Playing state: \(appState.gameState.currentTurn.local ? "📱" : "⏱️")")
      
      Spacer()
      
      BoardView(positioningInteractor: PositioningInteractor(appState: appState))
        .environment(appState)
      
      Spacer()
      
      // Debug
      Text("offset: \(appState.positioningState.dragOffset.width) \(appState.positioningState.dragOffset.height)")
      if let selectedGridPosition = appState.positioningState.selectedGridPosition, let piece = appState.gameState.board[selectedGridPosition.row][selectedGridPosition.column] {
        Text("selected: col: \(selectedGridPosition.column) row: \(selectedGridPosition.row) \(piece.icon)")
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
  } // body
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
