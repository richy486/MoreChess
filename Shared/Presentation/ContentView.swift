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
    Group {
      if appState.lobbyState.inGame == false {
        LobbyView(lobbyInteractor: LobbyInteractor(appState: appState))
      } else {
        GameView()
      }
    }
    .environment(appState)
  } // body
  
  
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
