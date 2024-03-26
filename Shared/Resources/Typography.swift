//
//  Typography.swift
//  MoreChess
//
//  Created by Richard Adem on 3/26/24.
//

import SwiftUI

enum CustomFontNames {
  static let nunitoSansCondensedBold = "NunitoSans7ptCondensed-Bold"
  static let nunitoRegular = "Nunito-Regular"
}

struct StyleFont {
  static var title: Font {
    let scaledSize = UIFontMetrics.default.scaledValue(for: 26)
    return Font.custom(CustomFontNames.nunitoSansCondensedBold, size: scaledSize)
  }
  static var body: Font {
    let scaledSize = UIFontMetrics.default.scaledValue(for: 16)
    return Font.custom(CustomFontNames.nunitoRegular, size: scaledSize)
  }
}
