//
//  LayoutDirection.swift
//  MoreChess
//
//  Created by Richard Adem on 3/26/24.
//

import UIKit

var isRTL: Bool {
  return UIApplication.shared
    .userInterfaceLayoutDirection == .rightToLeft
}
