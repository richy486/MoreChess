//
//  SimpleNavigationBackButton.swift
//  MoreChess (iOS)
//
//  Created by Richard Adem on 3/24/24.
//

import SwiftUI

extension View {
  func simpleNavigationBackButton(dismiss: DismissAction) -> some View {
    self
      .navigationBarBackButtonHidden(true)
      .toolbar {
        ToolbarItem(placement: .topBarLeading) {
          Button(action: {
            dismiss()
          }) {
            Label("Back", systemImage: "chevron.left")
              .foregroundStyle(.foreground)
          }
        }
      }
  }
}
