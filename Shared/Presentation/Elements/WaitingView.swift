//
//  WaitingView.swift
//  MoreChess (iOS)
//
//  Created by Richard Adem on 3/24/24.
//

import SwiftUI

struct WaitingView: View {
  
  @State var angle: Double = 0
  let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
  
  
  var body: some View {
    Group {
      Text("⌽")
        .rotationEffect(Angle.degrees(angle))
    }
    .onReceive(timer) { time in
      angle += 10
    }
  }
}

#Preview {
  WaitingView()
}
