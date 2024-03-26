//
//  MoreChessApp.swift
//  Shared
//
//  Created by Richard Adem on 10/10/23.
//

import SwiftUI

@main
struct MoreChessApp: App {
  
  
  init() {
    for family in UIFont.familyNames {
      print("\(family)")
      for name in UIFont.fontNames(forFamilyName: family) {
        print("   \(name)")
      }
    }
  }
   
  
  var body: some Scene {
    WindowGroup {
      ContentView()
    }
  }
}
