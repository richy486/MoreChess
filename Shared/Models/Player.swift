//
//  Player.swift
//  MoreChess (iOS)
//
//  Created by Richard Adem on 3/23/24.
//

import SwiftUI // For `Color`.

enum Player {
  case one
  case two
  
  var movingDown: Bool {
    switch self {
    case .one:
      false
    case .two:
      true
    }
  }
  
  var name: String {
    switch self {
    case .one:
      "One"
    case .two:
      "Two"
    }
  }
  
  var color: Color {
    switch self {
    case .one:
      Color(hue: 0.55, saturation: 0.75, brightness: 1)
    case .two:
      Color(hue: 0.15, saturation: 0.75, brightness: 1)
    }
  }
}
