//
//  SolidButtonStyle.swift
//  MoreChess (iOS)
//
//  Created by Richard Adem on 3/24/24.
//

import SwiftUI

struct SolidButtonStyle: ButtonStyle {
  func makeBody(configuration: Configuration) -> some View {
    configuration.label
      .padding()
      .background(.tint)
      .foregroundStyle(.background)
      .font(.headline)
      .clipShape(Capsule())
      .scaleEffect(configuration.isPressed ? 1.2 : 1)
      .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
  }
}

#Preview {
  Button("Press Me") {
  }
  .buttonStyle(SolidButtonStyle())
}
