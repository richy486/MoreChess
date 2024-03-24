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
  
  var body: some View {
    VStack {
      Text("Hosting")
      Text("share this code to other player: \(gameService.gameId)-\(gameService.clientId)")
      
      Spacer().frame(height: 20)
      
      Text("⏱️ Waiting for other player to join")
    }
    .navigationTitle("Host")    
    .navigationBarTitleDisplayMode(.inline)
    .simpleNavigationBackButton(dismiss: dismiss)
  }
}

#Preview {
  HostingView(gameService: GameService(gameId: "a", hostId: "v", clientId: "g"))
}
