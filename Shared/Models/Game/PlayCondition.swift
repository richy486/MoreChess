//
//  PlayCondition.swift
//  MoreChess (iOS)
//
//  Created by Richard Adem on 3/24/24.
//

import Foundation

enum PlayCondition: Equatable {
  case playing
  case win(player: Player)
  case tie
}
