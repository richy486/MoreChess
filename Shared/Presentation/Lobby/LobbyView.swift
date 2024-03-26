//
//  LobbyView.swift
//  MoreChess (iOS)
//
//  Created by Richard Adem on 3/24/24.
//

import SwiftUI

struct LobbyView: View {
  
  @Environment(AppState.self) private var appState
  let lobbyInteractor: LobbyInteractor
  
  @Environment(\.dismiss) var dismiss
  
  var body: some View {
    NavigationStack(path: pathBinding()) {
      
      home()
        .navigationDestination(for: LobbyState.LobbyPages.self) { destination in
          switch destination {
          case .host(let gameService):
            HostingView(gameService: gameService, lobbyInteractor: lobbyInteractor)
          case .client:
            ClientView(lobbyInteractor: lobbyInteractor)
          }
        }
    }
  } // body
  
  private func home() -> some View {
    VStack {
      Text("Host or join a new game")
        .font(StyleFont.title)
      Text("Select one option")
      Text("Color", comment: "Some text saying color")
      HStack {
        Button("Host") {
          lobbyInteractor.select(serviceType: .host)
        }
        .buttonStyle(PrimaryButtonStyle())
        
        Button("Join") {
          lobbyInteractor.select(serviceType: .client)
        }
        .buttonStyle(PrimaryButtonStyle())
      } // HStack
    }
    .style()
    .navigationTitle("More Chess 🐴")
    .navigationBarTitleDisplayMode(.inline)
  }
  
  private func pathBinding() -> Binding<[LobbyState.LobbyPages]> {
     .init(
        get: { appState.lobbyState.path },
        set: { appState.lobbyState.path = $0 }
     )
  }
}

#Preview {
  let appState = AppState()
  return LobbyView(lobbyInteractor: LobbyInteractor(appState: appState))
    .environment(appState)
}
