//
//  Players.swift
//  MoreChess (iOS)
//
//  Created by Richard Adem on 3/23/24.
//

import SwiftUI // For `Color`.

enum Players {
  static func one(local: Bool) -> Player {
    return Player(name: "One 🔵",
                  color: Color(hue: 0.55, saturation: 0.75, brightness: 1),
                  movingDown: false,
                  local: local)
  }
  static func two(local: Bool) -> Player {
    return Player(name: "Two 🟡",
                  color: Color(hue: 0.15, saturation: 0.75, brightness: 1),
                  movingDown: true,
                  local: local)
  }
}
