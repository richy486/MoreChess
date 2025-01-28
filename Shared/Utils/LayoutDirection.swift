//
//  LayoutDirection.swift
//  MoreChess
//
//  Created by Richard Adem on 3/26/24.
//

#if canImport(UIKit)
import UIKit
var isRTL: Bool {
  return UIApplication.shared.userInterfaceLayoutDirection == .rightToLeft
}
#endif

#if canImport(AppKit)
import AppKit
var isRTL: Bool {
  return NSApp.userInterfaceLayoutDirection == .rightToLeft
}
#endif
