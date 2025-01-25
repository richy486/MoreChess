//
//  Player.swift
//  MoreChess (iOS)
//
//  Created by Richard Adem on 3/23/24.
//

import SwiftUI // For `Color`.

struct Player: Equatable, Hashable, Identifiable {
  let id: UUID = UUID()
  let name: String
  let color: Color
  let movingDown: Bool
  let local: Bool
}
