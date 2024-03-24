//
//  ClientView.swift
//  MoreChess (iOS)
//
//  Created by Richard Adem on 3/24/24.
//

import SwiftUI

struct ClientView: View {
  @Environment(\.dismiss) var dismiss
  @Environment(AppState.self) private var appState
  
  let lobbyInteractor: LobbyInteractor
  
  var body: some View {
    VStack {
      Text("Client")
      ForEach(appState.lobbyState.availableGames, id: \.self) { gameService in
        Button("Game: \(gameService.gameId)") {
          lobbyInteractor.joinGame(gameService: gameService)
        }
      }
    }
    .navigationTitle("Join")
    .navigationBarTitleDisplayMode(.inline)
    .simpleNavigationBackButton(dismiss: dismiss)
    .onAppear(perform: lobbyInteractor.fetchAvailableGames)
  }
}

#Preview {
  let appState = AppState()
  return ClientView(lobbyInteractor: LobbyInteractor(appState: appState))
    .environment(appState)
}
