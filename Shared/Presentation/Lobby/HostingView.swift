//
//  HostingView.swift
//  MoreChess (iOS)
//
//  Created by Richard Adem on 3/24/24.
//

import SwiftUI

struct HostingView: View {
  @Environment(\.dismiss) var dismiss
  let gameService: GameService
  
  let lobbyInteractor: LobbyInteractor
  
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
    .navigationBarTitleDisplayMode(.inline)
    .simpleNavigationBackButton(dismiss: dismiss)
    .onAppear {
      lobbyInteractor.checkForOpponentClient(gameService: gameService)
    }
  }
}

#Preview {
  let appState = AppState()
  return HostingView(gameService: GameService(gameId: "a", hostId: "v", clientId: "g"), 
                     lobbyInteractor: LobbyInteractor(appState: appState))
}
