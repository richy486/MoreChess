//
//  GameView.swift
//  MoreChess (iOS)
//
//  Created by Richard Adem on 3/24/24.
//

import SwiftUI

struct GameView: View {
  
  @Environment(AppState.self) private var appState
  @Environment(PositioningInteractor.self) private var positioningInteractor

  var body: some View {
    VStack {
      
      playConditionView()
        .frame(maxHeight: .infinity, alignment: .top)

      BoardView()
        .frame(maxHeight: .infinity, alignment: .center)

      VStack {
        debugView()
        gameHistoryView()
      }
      .frame(maxHeight: .infinity, alignment: .bottom)
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
      VStack {
        Text("Player \(player.name) Won!")
        restartControl()
      }

    case .tie:
      VStack {
        Text("Tie!")
        restartControl()
      }
    }
  }

  func restartControl() -> some View {
    Button("Restart") {
      positioningInteractor.restartGame()
    }
    .buttonStyle(PrimaryButtonStyle())
  }

  func gameHistoryView() -> some View {
    ForEach(appState.gameState.players, id: \.id) { player in
      Text("\(player.name) wins \(appState.historyState.wins(for: player))")
    }
  }

  func debugView() -> some View {
    VStack {
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
    }
  }
}

#Preview {
  let appState = AppState()
  let positioningInteractor = PositioningInteractor(appState: appState)
  return GameView()
    .environment(appState)
    .environment(positioningInteractor)
}
