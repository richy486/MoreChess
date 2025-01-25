//
//  PresentationConstants.swift
//  MoreChess
//
//  Created by Richard Adem on 25/01/2025.
//

import SwiftUI

enum PresentationConstants {
  enum GameColor {
    static let targetColor = Color.red
    static let oddBoardColor = Color.gray
    static let evenBoardColor = Color.white
    static let boardOutline = Color.gray
  }
  enum ZIndex: Int {
    case normal = 0
    case target = 1
    case selected = 2
  }
  enum Layout {
    static let elementDiameter: CGFloat = 50
  }
}
