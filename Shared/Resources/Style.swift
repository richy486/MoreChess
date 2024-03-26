//
//  Style.swift
//  MoreChess (iOS)
//
//  Created by Richard Adem on 3/26/24.
//

import SwiftUI

// Add this to the root of your view.
struct StyleModifier: ViewModifier {
  func body(content: Content) -> some View {
    content
      .frame(maxWidth: .infinity, maxHeight: .infinity) // TODO: add option to disable this line.
      .background(Color.background)
      .foregroundStyle(Color.foreground)
      .environment(\.font, StyleFont.body)
  }
}

extension View {
  func style() -> some View {
    modifier(StyleModifier())
  }
}
