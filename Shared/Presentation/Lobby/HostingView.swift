//
//  HostingView.swift
//  MoreChess (iOS)
//
//  Created by Richard Adem on 3/24/24.
//

import SwiftUI

struct HostingView: View {
  @Environment(\.dismiss) var dismiss
  @Environment(LobbyInteractor.self) private var lobbyInteractor

  let gameService: GameService

  var body: some View {
    VStack {
      Text("Hosting")
      Text("share this code to other player: \(gameService.gameId)-\(gameService.clientId)")
      Spacer().frame(height: 20)
      
      HStack {
        WaitingView()
        Text("Waiting for other player to join")
      }
    }
    .navigationTitle("Host")    
#if os(iOS)
    .navigationBarTitleDisplayMode(.inline)
#endif
    .simpleNavigationBackButton(dismiss: dismiss)
    .style()
    .onAppear {
      lobbyInteractor.checkForOpponentClient(gameService: gameService)
    }
  }
}

#Preview {
  let appState = AppState()
  let lobbyInteractor = LobbyInteractor(lobbyState: appState.lobbyState)
  HostingView(gameService: GameService(gameId: "a", hostId: "v", clientId: "g"))
    .environment(lobbyInteractor)
}
