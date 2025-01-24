//
//  ContentView.swift
//  Shared
//
//  Created by Richard Adem on 10/10/23.
//

import SwiftUI

struct ContentView: View {
  @State var appState: AppState
  @State var positioningInteractor: PositioningInteractor

  init() {
    let appState = AppState()
    let positioningInteractor = PositioningInteractor(appState: appState)
    self._appState = State(wrappedValue: appState)
    self._positioningInteractor = State(wrappedValue: positioningInteractor)
  }

  var body: some View {
    Group {
      if appState.lobbyState.inGame == false {
        LobbyView(lobbyInteractor: LobbyInteractor(lobbyState: appState.lobbyState))
      } else {
        GameView()
      }
    }
    .environment(appState)
    .environment(positioningInteractor)
  } // body
  
  
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
