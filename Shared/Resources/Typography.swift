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
  static let nunitoSemiBold = "Nunito-SemiBold"
}

struct StyleFont {
  static var title: Font {
#if canImport(UIKit)
    let scaledSize = UIFontMetrics.default.scaledValue(for: 26)
    return Font.custom(CustomFontNames.nunitoSansCondensedBold, size: scaledSize)
#else
    // TODO: scale this properly for macOS native
    return Font.custom(CustomFontNames.nunitoSansCondensedBold, size: 26)
#endif
  }
  static var body: Font {
#if canImport(UIKit)
    let scaledSize = UIFontMetrics.default.scaledValue(for: 16)
    return Font.custom(CustomFontNames.nunitoRegular, size: scaledSize)
#else
    return Font.custom(CustomFontNames.nunitoSansCondensedBold, size: 16)
#endif
  }
  static let button: Font = {
#if canImport(UIKit)
    let scaledSize = UIFontMetrics.default.scaledValue(for: 18)
    return Font.custom(CustomFontNames.nunitoSemiBold, size: scaledSize)
#else
    return Font.custom(CustomFontNames.nunitoSansCondensedBold, size: 18)
#endif

  }()
}
